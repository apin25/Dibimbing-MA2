import 'package:flutter/material.dart';
import 'package:responsive_custom_widget/responsive_widgets/responsive_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen();
  }
}