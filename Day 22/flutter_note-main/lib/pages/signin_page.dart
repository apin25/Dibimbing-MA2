import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note/features/auth/auth_bloc.dart';
import 'package:flutter_note/features/auth/auth_event.dart';
import 'package:flutter_note/features/auth/auth_state.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.user != curr.user,
      listener: (context, state) {
        if (state.user != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (_) => false,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Signin",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 32),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.loading) {
                        return const CircularProgressIndicator();
                      }

                      return ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                SignInRequested(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                ),
                              );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text("Signin"),
                        ),
                      );
                    },
                  ),

                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (prev, curr) => prev.error != curr.error,
                    builder: (context, state) {
                      if (state.error == null) return const SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
