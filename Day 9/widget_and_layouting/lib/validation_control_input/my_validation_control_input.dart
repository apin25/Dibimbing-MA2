import 'package:flutter/material.dart';

Widget myValidationControlInput(){
  final _formKey = GlobalKey<FormState>();
  return Form(
    key: _formKey,
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Username'),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Please enter your username';
            }
            return null;
          }
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()){
              print("Form is valid!");
            }
          },
          child: Text('Submit'),
        ),
      ],
    )
  );
}
