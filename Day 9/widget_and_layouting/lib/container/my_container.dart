import 'package:flutter/material.dart';

Widget myContainer(){
  return Container(
    width: 100,
    height: 100,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4.0,
          offset: Offset(2,2),
        ),
      ],
    ),
    child: Text("Hello, I am child of container"),
  );
}