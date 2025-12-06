class SpokenLanguage {
  final String englishName;
  final String code;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.code,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      SpokenLanguage(
        englishName: json["english_name"],
        code: json["iso_639_1"],
        name: json["name"],
      );
}
