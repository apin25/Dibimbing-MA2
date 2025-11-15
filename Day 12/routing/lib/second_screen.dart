import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: const Center(
        child: Text(
          "Ini halaman kedua",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
