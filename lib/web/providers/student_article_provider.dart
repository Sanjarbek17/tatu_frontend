import 'package:http/http.dart' as http;
import 'package:tatu_frontend/web/models/article.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../constants.dart';
import '../../features/auth/data/auth_notifier.dart'; // Corrected import for AuthNotifier

final authProvider = Provider<AuthNotifier>((ref) => AuthNotifier());

class StudentArticleProvider extends StateNotifier<List<Article>> {
  final Ref ref;

  StudentArticleProvider(this.ref) : super([]);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles() async {
    _isLoading = true;
    state = [];

    final token = ref.read(authProvider).state.token;

    final url = Uri.parse('$baseUrl/api/articles/');
    try {
      final response = await http.get(url, headers: {'Authorization': 'Token $token'});
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        state = decodedData.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
    }
  }
}
