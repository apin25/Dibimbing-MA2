import 'package:flutter/material.dart';
import 'package:weather_app_alvin/pages/about_us_page.dart';
import 'package:weather_app_alvin/pages/home_page.dart';
import 'package:weather_app_alvin/pages/profile_page.dart';
import 'package:weather_app_alvin/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Weather App'),
        '/profile': (context) => const ProfilePage(title: 'Profile'),
        '/settings': (context) => const SettingsPage(title: 'Settings'),
        '/about-us': (context) => const AboutUsPage(title: 'About Us'),
      },
    );
  }
}

