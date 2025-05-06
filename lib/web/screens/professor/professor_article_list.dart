import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/core/constants.dart';
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
  String _selectedScreen = '/ilmiy-maqola'; // Default screen

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final articleProvider = Provider.of<ArticleProvider>(
      context,
      listen: false,
    );
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.professorProfile!.then((profile) {
      final username = profile?.username ?? 'default';
      debugPrint('Professor username: $username'); // Use debugPrint for logging
      articleProvider.fetchArticlesByUsername(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder:
          (ctx, articleProvider, _) => Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _selectedScreen = '/add-article';
                });
              },
              backgroundColor: Colors.blue, // Set background color to blue
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Tatu Dashboard',
                style: TextStyle(color: Colors.white),
              ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                ),
              ],
            ),
            body: Row(
              children: [
                CustomDrawer(
                  onItemSelected: (screen) {
                    setState(() {
                      _selectedScreen = screen;
                    });
                  },
                  selectedScreen: _selectedScreen,
                  isProfessor:
                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).isProfessor,
                ),
                Expanded(
                  child: Expanded(
                    child:
                        articleProvider.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : getSelectedScreen(_selectedScreen),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
