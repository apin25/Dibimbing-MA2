import 'package:flutter/material.dart';
import 'package:inventory_app_alvin/components/theme_data.dart';
import 'package:inventory_app_alvin/helper/auth_helper.dart';
import 'package:inventory_app_alvin/helper/firestore_user_helper.dart';
import 'package:inventory_app_alvin/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthHelper authHelper = AuthHelper();
  final fsUserHelper = FirestoreUserHelper();

  bool passwordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController psswdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    psswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: myWidth,
                child: const Text(
                  'Create your Account',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          SizedBox(
            width: myWidth,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Input Email',
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
          const SizedBox(height: 20),

          // Password
          SizedBox(
            width: myWidth,
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Input Username',
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
          const SizedBox(height: 20),

          // Password
          SizedBox(
            width: myWidth,
            child: TextField(
              controller: psswdController,
              obscureText: !passwordVisible,
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
          
          const SizedBox(height: 40),
          SizedBox(
            width: myWidth,
            child: ElevatedButton(
              onPressed: _register,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  'Register',
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

          // Login link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Have an account?",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text(
                  "Login",
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

  Future<void> _register() async {
    try {
      final result = await authHelper.signUpWithEmailAndPassword(
        emailController.text.trim(),
        psswdController.text.trim(),
      );

      if (result.user != null) {
        fsUserHelper.addUser(
          Users(
            id: result.user!.uid,
            email: emailController.text.trim(),
            username: usernameController.text.trim(),
          ),
        );
      }

      _showSnackbar('Signup success ${result.user?.email}');
    
      if (mounted) {
        Navigator.pop(context); 
      }

    } on FirebaseAuthException catch (e) {
      _showSnackbar('Signup fail: ${e.message}');
    } catch (e) {
      _showSnackbar('Signup fail');
    }

    emailController.clear();
    psswdController.clear();
  }

  void _showSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}