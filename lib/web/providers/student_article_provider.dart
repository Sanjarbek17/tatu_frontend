import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

class StudentArticleProvider with ChangeNotifier {
  List<dynamic> _articles = [];
  bool _isLoading = false;

  List<dynamic> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/api/articles/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _articles = json.decode(response.body);
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
