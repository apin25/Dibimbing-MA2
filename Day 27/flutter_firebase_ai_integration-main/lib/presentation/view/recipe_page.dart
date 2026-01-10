import 'package:flutter/material.dart';
import 'package:flutter_ai_integration/data/models/recipe_model.dart';

class RecipePage extends StatelessWidget {
  final RecipeModel recipe;

  const RecipePage(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resep')),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: [
          Text(
            recipe.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16),

          Text('Bahan - Bahan', style: Theme.of(context).textTheme.titleLarge),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                Text('${index + 1}. ${recipe.ingredients[index]}'),
            separatorBuilder: (context, index) => Divider(),
            itemCount: recipe.ingredients.length,
          ),

          SizedBox(height: 16),

          Text('Cara memasak', style: Theme.of(context).textTheme.titleLarge),

          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                Text('${index + 1}. ${recipe.steps[index]}'),
            separatorBuilder: (context, index) => Divider(),
            itemCount: recipe.steps.length,
          ),
        ],
      ),
    );
  }
}
