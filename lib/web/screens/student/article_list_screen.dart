import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/providers/auth_provider.dart';
import 'package:tatu_frontend/web/providers/student_article_provider.dart';

class ArticleListScreen extends StatefulWidget {
  static const routeName = '/student-dashboard';

  const ArticleListScreen({super.key});

  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  @override
  void initState() {
    super.initState();
    final articleProvider = Provider.of<StudentArticleProvider>(
      context,
      listen: false,
    );
    articleProvider.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentArticleProvider>(
      builder:
          (ctx, articleProvider, _) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text('Articles', style: TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    await authProvider.logout();
                    context.go('/login');
                  },
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text(
                      'Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body:
                articleProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: articleProvider.articles.length,
                      itemBuilder: (ctx, index) {
                        final article = articleProvider.articles[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          elevation: 4.0,
                          child: ListTile(
                            title: Text(
                              article['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'By ${article['professor_name']} - ${article['school_year']}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            onTap: () {
                              // Handle article open/download
                            },
                          ),
                        );
                      },
                    ),
          ),
    );
  }
}
