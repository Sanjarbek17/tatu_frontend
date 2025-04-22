import 'package:flutter/material.dart';
import 'package:tatu_frontend/web/screens/professor/article_form.dart';
import 'package:tatu_frontend/web/widgets/article_list_widget.dart';

const List<Map<String, dynamic>> drawerItems = [
  {'title': 'Ilmiy maqola', 'icon': Icons.article, 'screen': '/ilmiy-maqola'},
  {
    'title': 'Konferensiya materiali',
    'icon': Icons.event,
    'screen': '/konferensiya-materiali',
  },
  {'title': 'Monografiya', 'icon': Icons.book, 'screen': '/monografiya'},
  {
    'title': 'O‘quv qo‘llanma',
    'icon': Icons.menu_book,
    'screen': '/oquv-qollanma',
  },
  {
    'title': 'O‘quv-uslubiy qo‘llanma',
    'icon': Icons.school,
    'screen': '/oquv-uslubiy-qollanma',
  },
  {
    'title': 'Amaliy mashg‘ulotlar uchun metodik qo‘llanma',
    'icon': Icons.work,
    'screen': '/amaliy-mashgulotlar',
  },
  {'title': 'Patent yoki ixtiro', 'icon': Icons.lightbulb, 'screen': '/patent'},
  {
    'title': 'Grant asosida bajarilgan loyiha',
    'icon': Icons.assignment,
    'screen': '/grant-loyiha',
  },
  {
    'title': 'Dissertatsiyalar',
    'icon': Icons.school,
    'screen': '/dissertatsiyalar',
  },
  {
    'title': 'Ilmiy tarjimalar',
    'icon': Icons.translate,
    'screen': '/ilmiy-tarjimalar',
  },
  {
    'title': 'Texnik hisobotlar va ilmiy izohlar',
    'icon': Icons.report,
    'screen': '/texnik-hisobotlar',
  },
  {
    'title': 'Nazariy tadqiqotlar va modellar',
    'icon': Icons.model_training,
    'screen': '/nazariy-tadqiqotlar',
  },
];

Widget getSelectedScreen(String screen) {
  switch (screen) {
    case '/ilmiy-maqola':
      return Center(
        child: ArticleListWidget(),
      ); // Replace with actual screen widget
    case '/add-article':
      return Center(child: AddArticleScreen());
    case '/konferensiya-materiali':
      return Center(
        child: Text('Konferensiya materiali'),
      ); // Replace with actual screen widget
    case '/monografiya':
      return Center(
        child: Text('Monografiya'),
      ); // Replace with actual screen widget
    case '/oquv-qollanma':
      return Center(
        child: Text('O‘quv qo‘llanma'),
      ); // Replace with actual screen widget
    case '/oquv-uslubiy-qollanma':
      return Center(
        child: Text('O‘quv-uslubiy qo‘llanma'),
      ); // Replace with actual screen widget
    case '/amaliy-mashgulotlar':
      return Center(
        child: Text('Amaliy mashg‘ulotlar uchun metodik qo‘llanma'),
      ); // Replace with actual screen widget
    case '/patent':
      return Center(
        child: Text('Patent yoki ixtiro'),
      ); // Replace with actual screen widget
    case '/grant-loyiha':
      return Center(
        child: Text('Grant asosida bajarilgan loyiha'),
      ); // Replace with actual screen widget
    case '/dissertatsiyalar':
      return Center(
        child: Text('Dissertatsiyalar'),
      ); // Replace with actual screen widget
    case '/ilmiy-tarjimalar':
      return Center(
        child: Text('Ilmiy tarjimalar'),
      ); // Replace with actual screen widget
    case '/texnik-hisobotlar':
      return Center(
        child: Text('Texnik hisobotlar va ilmiy izohlar'),
      ); // Replace with actual screen widget
    case '/nazariy-tadqiqotlar':
      return Center(
        child: Text('Nazariy tadqiqotlar va modellar'),
      ); // Replace with actual screen widget
    default:
      return Center(child: Text('Unknown screen selected'));
  }
}
