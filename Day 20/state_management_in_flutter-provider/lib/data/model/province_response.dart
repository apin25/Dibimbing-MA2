class ProvinceResponse {
  final String id;
  final String name;

  ProvinceResponse({required this.id, required this.name});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) {
    return ProvinceResponse(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  ProvinceResponse copyWith({
    String? id,
    String? name,
  }) {
    return ProvinceResponse(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}