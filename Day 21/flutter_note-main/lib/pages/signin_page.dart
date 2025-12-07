import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class SigninPage extends ConsumerWidget {
  SigninPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider, (prev, next){
      if(next.user != null) {
        Navigator.pushNamed(context, '/home');
      }
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Signin", style: Theme.of(context).textTheme.headlineMedium),

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

                authState.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          await ref.read(authNotifierProvider.notifier).login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                          // if (ref.read(authNotifierProvider).user != null) {
                          //   Navigator.pushNamed(context, '/home');
                          // }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text("Signin"),
                        ),
                      ),

                if (authState.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(authState.error!, style: const TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
