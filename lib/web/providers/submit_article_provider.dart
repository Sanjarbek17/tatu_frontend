import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data'; // Import for Uint8List
import '../constants.dart';

class SubmitArticleProvider with ChangeNotifier {
  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  Future<void> submitArticle({
    required String title,
    required String description,
    required String schoolYear,
    required String filePath,
    Uint8List? fileBytes, // Add fileBytes for web compatibility
    String? fileName, // Add fileName for web compatibility
  }) async {
    _isSubmitting = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/api/articles/');
    try {
      final request =
          http.MultipartRequest('POST', url)
            ..fields['title'] = title
            ..fields['description'] = description
            ..fields['school_year'] = schoolYear;

      if (filePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath));
      } else if (fileBytes != null && fileName != null) {
        request.files.add(
          http.MultipartFile.fromBytes('file', fileBytes, filename: fileName),
        );
      } else {
        throw Exception('No file provided');
      }

      final response = await request.send();

      if (response.statusCode != 201) {
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
