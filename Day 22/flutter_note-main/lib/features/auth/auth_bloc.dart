import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note/auth_helper.dart';
import 'package:flutter_note/data/models/user_model.dart';
import 'package:flutter_note/features/auth/auth_event.dart';
import 'package:flutter_note/features/auth/auth_state.dart';
import 'package:flutter_note/firestore_user_helper.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthHelper authHelper;
  final FirestoreUserHelper firestoreUserHelper;

  late final StreamSubscription<User?> _authSub;

  AuthBloc(this.authHelper, this.firestoreUserHelper)
      : super(AuthState.initial()) {
    on<SignInRequested>(_onSignIn);
    on<LogoutRequested>(_onLogout);
    on<AuthUserChanged>(_onUserChanged);

    _authSub = authHelper.checkUserSignInState().listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  Future<void> _onSignIn(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final credential = await authHelper
          .signInWithEmailAndPassword(event.email, event.password);

      final user = credential.user;
      if (user != null) {
        await firestoreUserHelper.addUser(
          UserModel(
            userId: user.uid,
            userName: user.displayName ?? '',
            userEmail: user.email ?? '',
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authHelper.signOut();
  }

  void _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        user: event.user,
        loading: false,
        error: null,
      ),
    );
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
