import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/widgets/article_form.dart';
import 'package:tatu_frontend/web/widgets/article_list_widget.dart';
import 'package:tatu_frontend/web/providers/article_provider.dart';
import 'package:tatu_frontend/web/providers/auth_provider.dart';
import '../shared/drawer.dart';

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
              backgroundColor: Colors.blue, // Set the AppBar color
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
            body: Row(
              children: [
                CustomDrawer(),
                Expanded(
                  child:
                      articleProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ArticleListWidget(),
                ),
              ],
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
