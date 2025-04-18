import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/providers/article_provider.dart';
import 'package:tatu_frontend/web/providers/submit_article_provider.dart';
import 'web/providers/auth_provider.dart';
import 'web/screens/login_screen.dart';
import 'web/screens/student/article_list_screen.dart';
import 'web/screens/professor/article_list.dart';
import 'web/screens/professor/article_form.dart';
import 'web/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => SubmitArticleProvider()),
      ],
      child: MaterialApp(
        title: 'Tatu Frontend',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/student-dashboard': (context) => ArticleListScreen(),
          '/professor-dashboard': (context) => ProfessorArticleListScreen(),
          '/add-article': (context) => AddArticleScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}
