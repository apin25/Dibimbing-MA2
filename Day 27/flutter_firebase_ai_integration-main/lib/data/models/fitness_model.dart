class FitnessModel {
  final String title;
  final String description;
  final List<String> jadwal;

  FitnessModel({
    required this.title,
    required this.description,
    required this.jadwal,
  });

  factory FitnessModel.fromJson(Map<String, dynamic> json) {
    return FitnessModel(
      title: json['title'],
      description: json['description'],
      jadwal: List<String>.from(json['jadwal']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'jadwal': jadwal};
  }
}
