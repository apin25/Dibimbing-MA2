import 'package:flutter/material.dart';

Widget myTextFormField(){
  return TextFormField(
    decoration: InputDecoration(labelText: 'Email'),
    keyboardType: TextInputType.emailAddress,
    validator: (value){
      if (value == null || value.isEmpty){
        return 'Please enter your email';
      }
      return null;
    },
    onSaved: (value){
    },
  );
}