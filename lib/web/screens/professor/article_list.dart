import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/screens/professor/article_form.dart';
import '../../providers/article_provider.dart';
import '../../providers/auth_provider.dart';

class ProfessorArticleListScreen extends StatefulWidget {
  static const routeName = '/professor-dashboard';

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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    print('Professor username: ${authProvider.professorProfile?.username}');
    final username = authProvider.professorProfile?.username ?? 'sanjarbek';
    articleProvider.fetchArticlesByUsername(username);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder:
          (ctx, articleProvider, _) => Scaffold(
            appBar: AppBar(
              title: Text('My Articles'),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
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
            body:
                articleProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: articleProvider.articles.length,
                      itemBuilder: (ctx, index) {
                        final article = articleProvider.articles[index];
                        return ListTile(
                          title: Text(article.title),
                          subtitle: Text('School Year: ${article.schoolYear}'),
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
                context.go(AddArticleScreen.routeName);
              },
              child: Icon(Icons.add),
            ),
          ),
    );
  }
}
