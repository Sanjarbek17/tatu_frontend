import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';

class ArticleListScreen extends StatefulWidget {
  static const routeName = '/student-dashboard';

  const ArticleListScreen({super.key});

  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  List<dynamic> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    final url = Uri.parse('$baseUrl/api/articles/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _articles = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text(
                'Could not fetch articles. Please try again later.',
              ),
              actions: [
                TextButton(onPressed: () => context.pop(), child: Text('Okay')),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Articles')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (ctx, index) {
                  final article = _articles[index];
                  return ListTile(
                    title: Text(article['title']),
                    subtitle: Text(
                      'By ${article['professor_name']} - ${article['school_year']}',
                    ),
                    onTap: () {
                      // Handle article open/download
                    },
                  );
                },
              ),
    );
  }
}
