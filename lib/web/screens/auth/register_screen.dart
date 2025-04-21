import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../../providers/auth_provider.dart';
import '../../services/username_service.dart';

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
  final UsernameService _usernameService = UsernameService();
  bool _isLoading = false;
  bool _isProfessor = false;
  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  void _checkUsername(String username) async {
    try {
      final isAvailable = await _usernameService.checkUsername(username);
      print('Username availability: $isAvailable');
      setState(() {
        _usernameError = !isAvailable ? null : 'Username is already taken';
      });
    } catch (e) {
      setState(() {
        _usernameError = 'Error checking username';
      });
    }
  }

  void _checkEmail(String email) {
    setState(() {
      _emailError =
          EmailValidator.validate(email) ? null : 'Invalid email address';
    });
  }

  void _checkPassword(String password) {
    setState(() {
      if (password.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
      } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
        _passwordError = 'Password must contain at least one uppercase letter';
      } else if (!RegExp(r'[0-9]').hasMatch(password)) {
        _passwordError = 'Password must contain at least one number';
      } else {
        _passwordError = null;
      }
    });
  }

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 300, // Set a fixed width for the square shape
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    errorText: _usernameError,
                  ),
                  onChanged: (value) {
                    if (value.length >= 3) {
                      _checkUsername(value);
                    } else {
                      setState(() {
                        _usernameError =
                            'Username must be at least 3 characters';
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    errorText: _emailError,
                  ),
                  onChanged: (value) {
                    _checkEmail(value);
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    errorText: _passwordError,
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    _checkPassword(value);
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
