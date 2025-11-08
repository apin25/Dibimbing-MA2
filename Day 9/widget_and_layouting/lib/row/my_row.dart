import 'package:flutter/material.dart';

Widget myRow(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 10),
      Icon(Icons.star, color: Colors.yellow),
      Text('Hello, I am a child of Row', style: TextStyle(fontSize: 20)),
    ],
  );
}
