import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/screens/professor/article_form.dart';
import 'package:intl/intl.dart';
import '../../providers/article_provider.dart';
import '../../providers/auth_provider.dart';
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
                          : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Title',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'School Year',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Professor',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Created At',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ), // Space for action buttons
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: articleProvider.articles.length,
                                  itemBuilder: (ctx, index) {
                                    final article =
                                        articleProvider.articles[index];
                                    return Card(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16.0,
                                      ),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                article.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                article.schoolYear.toString(),
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                article.professor.toString(),
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                DateFormat(
                                                  'yyyy-MM-dd HH:mm',
                                                ).format(article.createdAt),
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.visibility,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    // Handle view article
                                                  },
                                                ),
                                                Consumer<AuthProvider>(
                                                  builder: (
                                                    ctx,
                                                    authProvider,
                                                    _,
                                                  ) {
                                                    return authProvider
                                                            .isProfessor
                                                        ? IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          onPressed: () {
                                                            // Handle edit article
                                                          },
                                                        )
                                                        : SizedBox.shrink();
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    // Handle delete article
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
