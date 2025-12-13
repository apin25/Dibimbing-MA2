// auth_state.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final User? user;
  final bool loading;
  final String? error;

  AuthState({
    this.user,
    this.loading = false,
    this.error,
  });

  factory AuthState.initial() => AuthState();

  AuthState copyWith({
    User? user,
    bool? loading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
