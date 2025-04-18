import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tatu_frontend/web/models/school_year.dart';
import 'package:tatu_frontend/web/models/user.dart';
import 'dart:convert';
import '../constants.dart';
import '../models/professor_profile.dart';
import '../models/student_profile.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isProfessor = false;
  ProfessorProfile? _professorProfile;
  StudentProfile? _studentProfile;

  String? get token => _token;
  bool get isProfessor => _isProfessor;
  ProfessorProfile? get professorProfile => _professorProfile;
  StudentProfile? get studentProfile => _studentProfile;

  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/custom-login/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody.isEmpty) {
          throw Exception('Empty response from server');
        }

        final responseData = json.decode(responseBody);
        if (responseData is! Map<String, dynamic>) {
          throw Exception('Invalid response format');
        }

        _token = responseData['token'];
        _isProfessor = responseData['is_professor'];

        if (_isProfessor) {
          _professorProfile = ProfessorProfile(
            id: 1, // Example ID
            user: User(
              id: 1, // Example ID
              username: username,
              email: '$username@example.com', // Example email
              isProfessor: true,
              isStudent: false,
            ),
            bio: 'Professor of Computer Science', // Example bio
            department: 'Computer Science', // Example department
          );
        } else {
          _studentProfile = StudentProfile(
            id: 1, // Example ID
            user: User(
              id: 1, // Example ID
              username: username,
              email: '$username@example.com', // Example email
              isProfessor: false,
              isStudent: true,
            ),
            schoolYear: SchoolYear(
              id: 1, // Example ID
              name: '2023-2024',
              startDate: DateTime(2023, 9, 1),
              endDate: DateTime(2024, 6, 30),
            ),
          );
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setBool('isProfessor', _isProfessor);

        notifyListeners();
      } else {
        final responseBody = response.body;
        if (responseBody.isNotEmpty) {
          final responseData = json.decode(responseBody);
          throw Exception(responseData['error'] ?? 'Login failed.');
        } else {
          throw Exception('Login failed with empty error response.');
        }
      }
    } catch (error) {
      debugPrint('Login error: $error'); // Log the error for debugging
      throw Exception('$error');
    }
  }

  Future<void> register(
    String username,
    String password,
    String email,
    bool isProfessor,
  ) async {
    final url = Uri.parse('$baseUrl/api/register/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'email': email,
          'is_professor': isProfessor,
          'is_student': !isProfessor,
        }),
      );

      if (response.statusCode != 201) {
        final responseData = json.decode(response.body);
        throw Exception(responseData['error'] ?? 'Registration failed.');
      }
    } catch (error) {
      debugPrint('Registration error: $error');
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    _isProfessor = false;
    _professorProfile = null;
    _studentProfile = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('isProfessor');

    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return;
    }

    _token = prefs.getString('token');
    _isProfessor = prefs.getBool('isProfessor') ?? false;

    // Fetch profile data from the server if needed
    // Example: await fetchProfile();

    notifyListeners();
  }
}
