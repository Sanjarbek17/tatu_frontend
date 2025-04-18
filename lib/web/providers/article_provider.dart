import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tatu_frontend/web/models/article.dart';
import 'package:tatu_frontend/web/models/school_year.dart';
import 'dart:convert';
import '../constants.dart';

class ArticleProvider with ChangeNotifier {
  final List<SchoolYear> _schoolYears = [
    SchoolYear(
      id: 1,
      name: '2023-2024',
      startDate: DateTime(2023, 9, 1),
      endDate: DateTime(2024, 6, 30),
    ),
    SchoolYear(
      id: 2,
      name: '2024-2025',
      startDate: DateTime(2024, 9, 1),
      endDate: DateTime(2025, 6, 30),
    ),
    SchoolYear(
      id: 3,
      name: '2025-2026',
      startDate: DateTime(2025, 9, 1),
      endDate: DateTime(2026, 6, 30),
    ),
  ];
  List<Article> _articles = [];
  bool _isLoading = false;

  List<SchoolYear> get schoolYears => _schoolYears;
  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  void addSchoolYear(SchoolYear year) {
    _schoolYears.add(year);
    notifyListeners();
  }

  void removeSchoolYear(SchoolYear year) {
    _schoolYears.removeWhere((sy) => sy.name == year.name);
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final url = Uri.parse('$baseUrl/api/professors/$professorId/articles/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _articles =
            jsonData.map((article) => Article.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
