import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data'; // Import for Uint8List
import '../constants.dart';
import 'auth_provider.dart';

class SubmitArticleProvider with ChangeNotifier {
  final AuthProvider authProvider;

  SubmitArticleProvider(this.authProvider);

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  Future<void> submitArticle({
    required String title,
    required String description,
    required int schoolYear, // Changed schoolYear to int type
    Uint8List? fileBytes, // Add fileBytes for web compatibility
    String? fileName, // Add fileName for web compatibility
  }) async {
    _isSubmitting = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/api/articles/upload/');
    try {
      final request =
          http.MultipartRequest('POST', url)
            ..fields['title'] = title
            ..fields['description'] = description
            ..fields['school_year'] =
                schoolYear.toString(); // Convert int to String

      final token = authProvider.token;
      if (token != null) {
        print('token: $token'); // Debug print for token
        request.headers['Authorization'] = 'Token $token';
      } else {
        throw Exception('No token found');
      }

      if (fileBytes != null && fileName != null) {
        request.files.add(
          http.MultipartFile.fromBytes('file', fileBytes, filename: fileName),
        );
      } else {
        throw Exception('No file provided');
      }

      final response = await request.send();

      if (response.statusCode != 201) {
        final responseBody = await response.stream.bytesToString();
        print(
          'Error: ${response.statusCode}, Response: $responseBody',
        ); // Debug print for status code and backend error
        throw Exception('Failed to submit article');
      }
    } catch (error) {
      debugPrint('Error submitting article: $error'); // Log the error
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
