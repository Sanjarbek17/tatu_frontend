import 'package:flutter/material.dart';
import 'package:tatu_frontend/web/screens/professor/article_form.dart';
import 'package:tatu_frontend/web/screens/professor/professor_settings_screen.dart';
import 'package:tatu_frontend/web/widgets/article_list_widget.dart';

const List<Map<String, dynamic>> drawerItems = [
  {'title': 'Dashboard', 'icon': Icons.dashboard, 'screen': '/dashboard'},
  {
    'title': 'Professor Articles',
    'icon': Icons.article,
    'screen': '/professor-articles',
  },
  {'title': 'Add Article', 'icon': Icons.add, 'screen': '/add-article'},
  {'title': 'Analytics', 'icon': Icons.analytics, 'screen': '/analytics'},
  {
    'title': 'Online Courses',
    'icon': Icons.school,
    'screen': '/online-courses',
  },
  {'title': 'Settings', 'icon': Icons.settings, 'screen': '/settings'},
];

Widget getSelectedScreen(String screen) {
  print('getselecred $screen');

  switch (screen) {
    case '/professor-articles':
      return ArticleListWidget();
    case '/add-article':
      return AddArticleScreen();
    case '/settings':
      return ProfessorSettingsScreen();
    default:
      return Center(child: Text('Unknown screen selected'));
  }
}
