import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

class ArticleProvider with ChangeNotifier {
  final List<String> _schoolYears = ['2023-2024', '2024-2025', '2025-2026'];
  List<dynamic> _articles = [];
  bool _isLoading = false;

  List<String> get schoolYears => _schoolYears;
  List<dynamic> get articles => _articles;
  bool get isLoading => _isLoading;

  void addSchoolYear(String year) {
    _schoolYears.add(year);
    notifyListeners();
  }

  void removeSchoolYear(String year) {
    _schoolYears.remove(year);
    notifyListeners();
  }

  void addArticle({
    required String title,
    required String description,
    required String schoolYear,
    required String fileName,
  }) {
    // Logic to add the article (e.g., saving to a list or database)
    // For now, we just print the details for demonstration purposes.
    print(
      'Article added: Title: $title, Description: $description, School Year: $schoolYear, File Name: $fileName',
    );
    notifyListeners();
  }

  Future<void> fetchArticles(String professorId) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/api/professors/$professorId/articles/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _articles = json.decode(response.body);
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
