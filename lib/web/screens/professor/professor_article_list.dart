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
  String _selectedScreen = '/professor-articles'; // Default screen

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

  Widget _getSelectedScreen() {
    switch (_selectedScreen) {
      case '/professor-articles':
        return ArticleListWidget();
      case '/add-article':
        return AddArticleScreen();
      default:
        return Center(child: Text('Unknown screen selected'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder:
          (ctx, articleProvider, _) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue, // Set the AppBar color
              title: Text(
                'My Articles',
                style: TextStyle(
                  color: Colors.white,
                ), // Set the text color to white
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ), // Set icon color to white
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
                  selectedScreen: _selectedScreen, // Pass selected screen
                ),
                Expanded(
                  child:
                      articleProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : _getSelectedScreen(),
                ),
              ],
            ),
          ),
    );
  }
}
