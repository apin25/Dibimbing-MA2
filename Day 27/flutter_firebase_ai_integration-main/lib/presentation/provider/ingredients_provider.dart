import 'package:flutter/material.dart';

class IngredientsNotifier extends ChangeNotifier {
  final List<TextEditingController> _controllers = [];

  List<TextEditingController> get controllers => _controllers;

  void addIngredientField() {
    _controllers.add(TextEditingController());
    notifyListeners();
  }

  void removeIngredientField(int index) {
    _controllers[index].dispose();
    _controllers.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
