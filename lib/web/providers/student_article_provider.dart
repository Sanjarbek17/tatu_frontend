import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tatu_frontend/web/models/article.dart';
import 'package:tatu_frontend/web/providers/auth_provider.dart';
import 'dart:convert';
import '../constants.dart';

class StudentArticleProvider with ChangeNotifier {
  final AuthProvider authProvider;

  List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  StudentArticleProvider(this.authProvider);

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    final token = authProvider.token;

    final url = Uri.parse('$baseUrl/api/articles/');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        _articles = decodedData.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
