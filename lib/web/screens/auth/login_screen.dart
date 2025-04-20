import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/screens/auth/register_screen.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(_usernameController.text, _passwordController.text);

      final isProfessor =
          Provider.of<AuthProvider>(context, listen: false).isProfessor;
      if (isProfessor) {
        context.go('/professor-dashboard');
      } else {
        context.go('/student-dashboard');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Login Failed'),
              content: Text(error.toString()),
              actions: [
                TextButton(onPressed: () => context.pop(), child: Text('Okay')),
              ],
            ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: _login, child: Text('Login')),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    context.go(RegisterScreen.routeName);
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
