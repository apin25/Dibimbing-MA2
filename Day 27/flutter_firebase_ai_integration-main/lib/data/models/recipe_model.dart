class RecipeModel {
  final String title;
  final List<String> ingredients;
  final List<String> steps;

  RecipeModel({
    required this.title,
    required this.ingredients,
    required this.steps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      steps: List<String>.from(json['steps'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'ingredients': ingredients, 'steps': steps};
  }
}
