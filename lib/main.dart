import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/router.dart';
import 'package:tatu_frontend/web/providers/article_provider.dart';
import 'package:tatu_frontend/web/providers/submit_article_provider.dart';
import 'package:tatu_frontend/web/providers/auth_provider.dart';
import 'package:tatu_frontend/web/providers/student_article_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _tryAutoLogin();
  }

  void _tryAutoLogin() async {
    print('auto login ');
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isLoggedIn = await authProvider.tryAutoLogin();

      if (isLoggedIn) {
        final isProfessor = authProvider.isProfessor;
        if (isProfessor) {
          context.go('/professor-dashboard');
        } else {
          context.go('/student-dashboard');
        }
      }
    } catch (error) {
      // Handle auto-login error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(
          create:
              (context) => SubmitArticleProvider(
                Provider.of<AuthProvider>(context, listen: false),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (_) => StudentArticleProvider(
                Provider.of<AuthProvider>(context, listen: false),
              ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Tatu Frontend',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: router,
      ),
    );
  }
}
