import 'package:flutter_note/auth_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authHelperProvider));
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authHelperProvider).checkUserSignInState();
});

final authHelperProvider = Provider<AuthHelper>((ref) {
  return AuthHelper();
});


class AuthState {
  final bool loading;
  final User? user;
  final String? error;

  AuthState({
    this.loading = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? loading,
    User? user,
    String? error,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthHelper helper;

  AuthNotifier(this.helper) : super(AuthState());

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(loading: true, error: null);

      final credential =
          await helper.signInWithEmailAndPassword(email, password);

      state = state.copyWith(
        loading: false,
        user: credential.user,
      );
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.message,
      );
    }
  }

  Future<void> register(String email, String password) async {
    try {
      state = state.copyWith(loading: true);

      final credential =
          await helper.signUpWithEmailAndPassword(email, password);

      state = state.copyWith(
        loading: false,
        user: credential.user,
      );
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.message,
      );
    }
  }

  Future<void> logout() async {
    await helper.firebaseAuth.signOut();
    state = AuthState(); 
  }
}
