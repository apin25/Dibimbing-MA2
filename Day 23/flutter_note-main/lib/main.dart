import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_note/auth_helper.dart';
import 'package:flutter_note/firebase_options.dart';
import 'package:flutter_note/firestore_user_helper.dart';
import 'package:flutter_note/pages/note_home_page.dart';
import 'package:flutter_note/pages/signin_page.dart';
import 'package:flutter_note/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // inject controller
  Get.put(AuthController(AuthHelper(), FirestoreUserHelper()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Note',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime),
      ),
      initialRoute: '/signin',
      getPages: [
        GetPage(name: '/signin', page: () => const SigninPage()),
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(name: '/home', page: () => const NoteHomePage()),
      ],
    );
  }
}
