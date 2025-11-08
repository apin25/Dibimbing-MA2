import 'package:flutter/material.dart';

Widget myColumn(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Hello, I am a child of Column', style: TextStyle(fontSize: 20)),
      SizedBox(height: 10),
      Icon(Icons.star, color: Colors.yellow),
    ],
  );
}