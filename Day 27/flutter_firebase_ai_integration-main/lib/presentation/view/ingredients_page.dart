import 'package:flutter/material.dart';
import 'package:flutter_ai_integration/presentation/provider/ingredients_provider.dart';
import 'package:flutter_ai_integration/presentation/provider/recipe_provider.dart';
import 'package:flutter_ai_integration/presentation/view/recipe_page.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IngredientsNotifier(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Ingredients')),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: IngredientsForm(),
        ),
      ),
    );
  }
}

class IngredientsForm extends StatelessWidget {
  const IngredientsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<IngredientsNotifier>();

    return Column(
      children: [
        Expanded(child: _buildIngredientListSection(notifier)),
        const SizedBox(height: 16),
        _buildSearchButton(context),
      ],
    );
  }

  Widget _buildIngredientListSection(IngredientsNotifier notifier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAddButton(notifier),
        const SizedBox(height: 8),
        Expanded(child: _buildIngredientList(notifier)),
      ],
    );
  }

  Widget _buildIngredientList(IngredientsNotifier notifier) {
    return ListView.builder(
      itemCount: notifier.controllers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildIngredientField(notifier, index),
        );
      },
    );
  }

  Widget _buildIngredientField(IngredientsNotifier notifier, int index) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: notifier.controllers[index],
            decoration: InputDecoration(
              labelText: 'Bahan ${index + 1}',
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () => notifier.removeIngredientField(index),
        ),
      ],
    );
  }

  Widget _buildAddButton(IngredientsNotifier notifier) {
    return ElevatedButton.icon(
      onPressed: notifier.addIngredientField,
      icon: const Icon(Icons.add),
      label: const Text('Tambah Bahan'),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          context.loaderOverlay.show();
          try {
            final listIngredients = context
                .read<IngredientsNotifier>()
                .controllers
                .map((controller) => controller.text)
                .toList();

            if (listIngredients.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Masukkan bahan-bahan')),
              );
              return;
            }

            final recipe = await context.read<RecipeNotifier>().getRecipe(
              listIngredients,
            );

            if (recipe == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal mendapatkan resep')),
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipePage(recipe)),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal mendapatkan resep => $e')),
            );
          } finally {
            context.loaderOverlay.hide();
          }
        },
        icon: const Icon(Icons.search),
        label: const Text('Cari Resep'),
      ),
    );
  }
}
