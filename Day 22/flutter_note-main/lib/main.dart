import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note/auth_helper.dart';
import 'package:flutter_note/core/bloc_observer.dart';
import 'package:flutter_note/features/auth/auth_bloc.dart';
import 'package:flutter_note/features/auth/auth_gate.dart';
import 'package:flutter_note/firebase_options.dart';
import 'package:flutter_note/firestore_user_helper.dart';
import 'package:flutter_note/pages/note_home_page.dart';
import 'package:flutter_note/pages/signin_page.dart';
import 'package:flutter_note/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = StateObserve(); 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            AuthHelper(),
            FirestoreUserHelper(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Note',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime),
        ),
        home: const AuthGate(),
        routes: {
          '/home': (_) => const NoteHomePage(),
          '/signin': (_) => SigninPage(),
          '/signup': (_) => const SignupPage(),
        },
      ),
    );
  }
}
