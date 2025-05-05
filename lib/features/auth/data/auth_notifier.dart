import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isAuthenticated, // Corrected to use @Default
    @Default('') String errorMessage,
    String? token, // Added token field
  }) = _AuthState;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<bool> login(String username, String password) async {
    state = state.copyWith(errorMessage: '');
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      if (username == 'admin' && password == 'password') {
        state = state.copyWith(isAuthenticated: true);
        return true;
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isAuthenticated: false);
  }

  Future<bool> tryAutoLogin() async {
    // Simulate auto-login logic
    await Future.delayed(const Duration(seconds: 1));
    return state.isAuthenticated;
  }
}
