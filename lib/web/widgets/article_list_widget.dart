import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatu_frontend/main.dart';

class ArticleListWidget extends ConsumerWidget {
  const ArticleListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Article List')),
      body:
          articleState.isLoading
              ? Center(child: CircularProgressIndicator())
              : articleState.articles.isEmpty
              ? Center(
                child: Text(
                  'No articles available.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              )
              : ListView.builder(
                itemCount: articleState.articles.length,
                itemBuilder: (context, index) {
                  final article = articleState.articles[index];
                  return ListTile(
                    title: Text(article),
                    trailing:
                        authState.isAuthenticated
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.visibility, color: Colors.blue),
                                  onPressed: () {
                                    // Handle view article
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () {
                                    // Handle edit article
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Handle delete article
                                  },
                                ),
                              ],
                            )
                            : null,
                  );
                },
              ),
    );
  }
}
