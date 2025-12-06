class ProductionCountry {
  final String code;
  final String name;

  ProductionCountry({
    required this.code,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        code: json["iso_3166_1"],
        name: json["name"],
      );
}
