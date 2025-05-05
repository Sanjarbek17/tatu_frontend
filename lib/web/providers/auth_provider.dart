import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../constants.dart';
import '../models/professor_profile.dart';
import '../models/student_profile.dart';

class AuthState {
  final String? token;
  final bool isProfessor;
  final ProfessorProfile? professorProfile;
  final StudentProfile? studentProfile;

  AuthState({this.token, this.isProfessor = false, this.professorProfile, this.studentProfile});

  AuthState copyWith({
    String? token,
    bool? isProfessor,
    ProfessorProfile? professorProfile,
    StudentProfile? studentProfile,
  }) {
    return AuthState(
      token: token ?? this.token,
      isProfessor: isProfessor ?? this.isProfessor,
      professorProfile: professorProfile ?? this.professorProfile,
      studentProfile: studentProfile ?? this.studentProfile,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  final Dio _dio = Dio();
  Future<bool> login(String username, String password) async {
    final url = '$baseUrl/api/custom-login/';
    try {
      final response = await _dio.post(url, data: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        final responseData = response.data;
        final token = responseData['token'];
        final isProfessor = responseData['is_professor'];

        ProfessorProfile? professorProfile;
        StudentProfile? studentProfile;

        if (isProfessor) {
          professorProfile = ProfessorProfile.fromJson(responseData);
        } else {
          studentProfile = StudentProfile.fromJson(responseData);
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setBool('isProfessor', isProfessor);

        if (isProfessor && professorProfile != null) {
          await prefs.setString('professorProfile', professorProfile.toJson().toString());
        } else if (studentProfile != null) {
          await prefs.setString('studentProfile', studentProfile.toJson().toString());
        }

        state = state.copyWith(
          token: token,
          isProfessor: isProfessor,
          professorProfile: professorProfile,
          studentProfile: studentProfile,
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final isProfessor = prefs.getBool('isProfessor') ?? false;

    if (token == null) {
      return false;
    }

    ProfessorProfile? professorProfile;
    StudentProfile? studentProfile;

    if (isProfessor) {
      final professorData = prefs.getString('professorProfile');
      if (professorData != null) {
        professorProfile = ProfessorProfile.fromJson(jsonDecode(professorData));
      }
    } else {
      final studentData = prefs.getString('studentProfile');
      if (studentData != null) {
        studentProfile = StudentProfile.fromJson(jsonDecode(studentData));
      }
    }

    state = state.copyWith(
      token: token,
      isProfessor: isProfessor,
      professorProfile: professorProfile,
      studentProfile: studentProfile,
    );

    return true;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
