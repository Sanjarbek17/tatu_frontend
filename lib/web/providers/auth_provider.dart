import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
  bool get isProfessor => professorProfile != null;
  bool get isStudent => studentProfile != null;
  Future<ProfessorProfile?>? get professorProfile async {
    if (_professorProfile == null) {
      final prefs = await SharedPreferences.getInstance();
      final professorProfileString = prefs.getString('professorProfile');
      if (professorProfileString != null) {
        _professorProfile = ProfessorProfile.fromJson(
          json.decode(professorProfileString),
        );
      }
    }
    return _professorProfile;
  }

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
        debugPrint(responseData.toString());
        debugPrint('Login response data: $responseData');
        if (_isProfessor) {
          _professorProfile = ProfessorProfile.fromJson(responseData);
          debugPrint('Parsed ProfessorProfile: ${_professorProfile?.toJson()}');
        } else {
          _studentProfile = StudentProfile.fromJson(responseData);
          debugPrint('Parsed StudentProfile: ${_studentProfile?.toJson()}');
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setBool('isProfessor', _isProfessor);
        if (_isProfessor && _professorProfile != null) {
          final professorProfileJson = json.encode(_professorProfile!.toJson());
          debugPrint(
            'Saving professorProfile to SharedPreferences: $professorProfileJson',
          );
          await prefs.setString('professorProfile', professorProfileJson);
        } else if (_studentProfile != null) {
          await prefs.setString(
            'studentProfile',
            json.encode(_studentProfile!.toJson()),
          );
        }

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

  Future<bool> tryAutoLogin() async {
    print('Trying to auto-login...');
    print('professorProfile: $_professorProfile');
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return false;
    }

    _token = prefs.getString('token');
    _isProfessor = prefs.getBool('isProfessor') ?? false;
    print('isProfessor: $_isProfessor');
    if (_isProfessor) {
      final professorProfileString = prefs.getString('professorProfile');
      debugPrint('Retrieved professorProfileString: $professorProfileString');
      _professorProfile = ProfessorProfile.fromJson(
        json.decode(professorProfileString!),
      );
    } else {
      final studentProfileString = prefs.getString('studentProfile');
      _studentProfile = StudentProfile.fromJson(
        json.decode(studentProfileString!),
      );
    }
    print('professorProfile2: ${_professorProfile?.username}');

    notifyListeners();
    return true;
  }
}
