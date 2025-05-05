import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatu_frontend/main.dart';
import '../shared/drawer.dart';

class ProfessorArticleListScreen extends ConsumerWidget {
  static const routeName = '/professor-dashboard';

  const ProfessorArticleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add-article');
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Tatu Dashboard', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/200')),
          ),
        ],
      ),
      body: Row(
        children: [
          CustomDrawer(
            onItemSelected: (screen) {
              context.go(screen);
            },
            selectedScreen: ProfessorArticleListScreen.routeName,
            isProfessor: authState.isAuthenticated,
          ),
          Expanded(
            child:
                articleState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: articleState.articles.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(articleState.articles[index]));
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
