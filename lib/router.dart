
import 'package:go_router/go_router.dart';
import 'package:tatu_frontend/web/screens/auth/login_screen.dart';
import 'package:tatu_frontend/web/screens/auth/register_screen.dart';
import 'package:tatu_frontend/web/screens/professor/article_form.dart';
import 'package:tatu_frontend/web/screens/professor/article_list.dart';
import 'package:tatu_frontend/web/screens/student/article_list_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: LoginScreen.routeName,
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
