import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/providers/auth_provider.dart';
import 'package:tatu_frontend/web/screens/auth/login_screen.dart';
import 'package:tatu_frontend/web/screens/auth/register_screen.dart';
import 'package:tatu_frontend/web/widgets/article_form.dart';
import 'package:tatu_frontend/web/screens/professor/professor_article_list.dart';
import 'package:tatu_frontend/web/screens/student/article_list_screen.dart';

class LoginObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _checkLoginStatus(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _checkLoginStatus(newRoute);
    }
  }

  void _checkLoginStatus(Route<dynamic> route) async {
    if (route.settings.name == RegisterScreen.routeName ||
        route.settings.name == LoginScreen.routeName ||
        route.settings.name == null) {
      return;
    }
    final authProvider = route.navigator!.context.read<AuthProvider>();
    final isLoggedIn = await authProvider.tryAutoLogin();
    if (!isLoggedIn && route.settings.name != LoginScreen.routeName) {
      print('screen name: ${route.settings.name}');

      GoRouter.of(route.navigator!.context).go(LoginScreen.routeName);
    }
  }
}

final GoRouter router = GoRouter(
  initialLocation: LoginScreen.routeName,
  observers: [LoginObserver()],
  errorBuilder:
      (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                GoRouter.of(context).pop();
              } else {
                GoRouter.of(context).go(LoginScreen.routeName);
              }
            },
          ),
        ),
        body: const Center(child: Text('404 - Page Not Found')),
      ),
  routes: [
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: ArticleListScreen.routeName,
      builder: (context, state) => const ArticleListScreen(),
    ),
    GoRoute(
      path: ProfessorArticleListScreen.routeName,
      builder: (context, state) => const ProfessorArticleListScreen(),
    ),
    GoRoute(
      path: AddArticleScreen.routeName,
      builder: (context, state) => const AddArticleScreen(),
    ),
    GoRoute(
      path: RegisterScreen.routeName,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
