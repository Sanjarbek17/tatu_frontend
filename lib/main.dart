import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatu_frontend/router.dart';
import 'package:tatu_frontend/features/article/data/article_notifier.dart';
import 'package:tatu_frontend/features/article/data/submit_article_notifier.dart';
import 'package:tatu_frontend/features/auth/data/auth_notifier.dart';
import 'package:tatu_frontend/features/article/data/student_article_notifier.dart';

final articleProvider = StateNotifierProvider<ArticleNotifier, ArticleState>(
  (ref) => ArticleNotifier(),
);
final submitArticleProvider = StateNotifierProvider<SubmitArticleNotifier, SubmitArticleState>(
  (ref) => SubmitArticleNotifier(),
);
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
final studentArticleProvider = StateNotifierProvider<StudentArticleNotifier, StudentArticleState>(
  (ref) => StudentArticleNotifier(),
);

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tatu Frontend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}
