import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_ai_integration/data/models/recipe_model.dart';
import 'package:flutter_ai_integration/services/ai_service.dart';

class RecipeRepository {
  final AiService aiService;

  const RecipeRepository(this.aiService);

  Future<RecipeModel?> getRecipeByIngredients(List<String> ingredients) async {
    final prompt =
        'Buat resep menggunakan bahan-bahan berikut: ${ingredients.join(', ')}'
        '\n Dengan format Json: {"title": "Nama Resep", "ingredients": ["Bahan 1", "Bahan 2", ...], "steps": ["Langkah 1", "Langkah 2", ...]}';
    final result = await aiService.generateText(prompt);

    if (result == null) {
      return null;
    }
    return RecipeModel.fromJson(json.decode(result));
  }

  Future<RecipeModel?> getRecipeByImage(Uint8List imageBytes) async {
    final imagePart = InlineDataPart('image/jpeg', imageBytes);

    final prompt =
        'Buat resep berdasarkan gambar berikut'
        '\n Dengan format Json: {"title": "Nama Resep", "ingredients": ["Bahan 1", "Bahan 2", ...], "steps": ["Langkah 1", "Langkah 2", ...]}';
    final result = await aiService.generateTextByImage(
      prompt: prompt,
      imageParts: [imagePart],
    );

    if (result == null) {
      return null;
    }

    return RecipeModel.fromJson(json.decode(result));
  }
}
