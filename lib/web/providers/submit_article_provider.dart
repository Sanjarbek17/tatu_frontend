import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class SubmitArticleProvider with ChangeNotifier {
  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  Future<void> submitArticle({
    required String title,
    required String description,
    required String schoolYear,
    required String filePath,
  }) async {
    _isSubmitting = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/api/articles/');
    try {
      final request =
          http.MultipartRequest('POST', url)
            ..fields['title'] = title
            ..fields['description'] = description
            ..fields['school_year'] = schoolYear
            ..files.add(await http.MultipartFile.fromPath('file', filePath));

      final response = await request.send();

      if (response.statusCode != 201) {
        throw Exception('Failed to submit article');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
