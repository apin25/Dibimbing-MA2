import 'package:flutter/material.dart';
import 'package:inventory_app_alvin/components/theme_data.dart';
import 'package:inventory_app_alvin/helper/auth_helper.dart';
import 'package:inventory_app_alvin/helper/firestore_user_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthHelper authHelper = AuthHelper();
  final fsUserHelper = FirestoreUserHelper();
  bool passwordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController psswdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    psswdController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail() async {
    try {
      final result = await authHelper.signInWithEmailAndPassword(
        emailController.text.trim(),
        psswdController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signin success as ${result.user?.email}')),
      );

      Navigator.pushReplacementNamed(context, '/inventory');

    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signin fail: $e')),
      );
    }

    emailController.clear();
    psswdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          SizedBox(
            width: myWidth,
            child: Text(
              'Login to Your Account',
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          /// Email
          SizedBox(
            width: myWidth,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Input Email',
                hintStyle: const TextStyle(color: AppTheme.textGrey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppTheme.borderGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppTheme.primary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          /// Password
          SizedBox(
            width: myWidth,
            child: TextField(
              controller: psswdController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Input Password',
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                fillColor: AppTheme.secondaryLight,
                hintStyle: const TextStyle(color: AppTheme.textGrey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppTheme.borderGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppTheme.primary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),

          SizedBox(
            width: myWidth,
            child: ElevatedButton(
              onPressed: _signInWithEmail,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      )
    );
  }
}
