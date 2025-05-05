import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tatu_frontend/main.dart';

class ProfessorSettingsScreen extends ConsumerWidget {
  static const routeName = '/settings';

  const ProfessorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${authState.isAuthenticated ? 'User' : 'Guest'}'),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).logout();
                context.go('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
