import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isProfessor = false;

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).register(
        _usernameController.text,
        _passwordController.text,
        _emailController.text,
        _isProfessor,
      );

      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Success'),
              content: Text('Registration successful!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.go(
                      '/login',
                    ); // Navigate to login screen using go_router
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Okay'),
                ),
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
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              Row(
                children: [
                  Text('Register as:'),
                  SizedBox(width: 10),
                  DropdownButton<bool>(
                    value: _isProfessor,
                    items: [
                      DropdownMenuItem(value: false, child: Text('Student')),
                      DropdownMenuItem(value: true, child: Text('Professor')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _isProfessor = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: _register,
                    child: Text('Register'),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
