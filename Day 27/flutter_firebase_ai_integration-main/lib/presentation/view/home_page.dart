import 'package:flutter/material.dart';
import 'package:flutter_ai_integration/presentation/provider/recipe_provider.dart';
import 'package:flutter_ai_integration/presentation/view/fitness_page.dart';
import 'package:flutter_ai_integration/presentation/view/ingredients_page.dart';
import 'package:flutter_ai_integration/presentation/view/recipe_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          Card(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu, size: 48),
                    const SizedBox(height: 16),
                    const Text(
                      'Cari Resep berdasarkan bahan',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const IngredientsPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 48),
                    const SizedBox(height: 16),
                    const Text(
                      'Cari Resep dari gambar',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onTap: () {
                imagePicker(context);
              },
            ),
          ),
          Card(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fitness_center, size: 48),
                    const SizedBox(height: 16),
                    const Text(
                      'Cari Program Fitness',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FitnessPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void imagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Pilih dari galeri'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Ambil foto'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
        ],
      ),
    );

    if (source == null) return;

    final XFile? image = await picker.pickImage(source: source);

    context.loaderOverlay.show();
    try {
      final imageBytes = await image?.readAsBytes();

      if (imageBytes == null) return;

      final response = await context.read<RecipeNotifier>().getRecipeByImage(
        imageBytes,
      );

      if (response == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal mendapatkan resep')));
        return;
      }

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => RecipePage(response)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mendapatkan resep')));
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
