import 'package:flutter/material.dart';
import 'package:flutter_note/controller/auth_controller.dart';
import 'package:get/get.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<AuthController>().user.value != null) {
        Future.microtask(() => Get.offAllNamed('/home'));
      }

      return Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Signin",
                      style: Theme.of(context).textTheme.headlineMedium),

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

                  Get.find<AuthController>().loading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            Get.find<AuthController>().signIn(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text("Signin"),
                          ),
                        ),

                  if (Get.find<AuthController>().error.value != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        Get.find<AuthController>().error.value!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
