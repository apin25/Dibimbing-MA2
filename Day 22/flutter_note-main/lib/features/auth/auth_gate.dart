import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note/features/auth/auth_bloc.dart';
import 'package:flutter_note/features/auth/auth_state.dart';
import 'package:flutter_note/pages/note_home_page.dart';
import 'package:flutter_note/pages/signin_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // 1. loading awal (nunggu Firebase)
        if (state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. sudah login
        if (state.user != null) {
          return const NoteHomePage();
        }

        // 3. belum login
        return SigninPage();
      },
    );
  }
}
