// auth_event.dart
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final User? user;
  AuthUserChanged(this.user);
}
