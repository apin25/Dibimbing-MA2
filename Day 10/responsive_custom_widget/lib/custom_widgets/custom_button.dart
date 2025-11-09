import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const MyCustomButton({
    super.key,
    required this.label, 
    required this.color, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () => onTap(), 
      child: Text(label, style: TextStyle(color:Colors.white),)
    );
  }
}