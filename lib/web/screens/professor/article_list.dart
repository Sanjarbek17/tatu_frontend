import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/article_provider.dart';

class ProfessorArticleListScreen extends StatefulWidget {
  const ProfessorArticleListScreen({super.key});

  @override
  _ProfessorArticleListScreenState createState() =>
      _ProfessorArticleListScreenState();
}

class _ProfessorArticleListScreenState
    extends State<ProfessorArticleListScreen> {
  @override
  void initState() {
    super.initState();
    final articleProvider = Provider.of<ArticleProvider>(
      context,
      listen: false,
    );
    articleProvider.fetchArticles('<id>');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder:
          (ctx, articleProvider, _) => Scaffold(
            appBar: AppBar(title: Text('My Articles')),
            body:
                articleProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: articleProvider.articles.length,
                      itemBuilder: (ctx, index) {
                        final article = articleProvider.articles[index];
                        return ListTile(
                          title: Text(article['title']),
                          subtitle: Text(
                            'School Year: ${article['school_year']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Handle edit article
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Handle delete article
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add-article');
              },
              child: Icon(Icons.add),
            ),
          ),
    );
  }
}
