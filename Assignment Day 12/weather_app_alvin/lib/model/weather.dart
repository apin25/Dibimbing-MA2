import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Weather {
  final int id;
  final String kota;
  final int suhu;
  final String kondisi;
  final int uvIndex;
  final int kelembapan;
  final int angin;

  Weather({required this.id, required this.kota, required this.suhu, required this.kondisi, required this.uvIndex, required this.kelembapan, required this.angin});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'], 
        kota: json['kota'], 
        suhu: json['suhu'], 
        kondisi: json['kondisi'], 
        uvIndex: json['uv_index'], 
        kelembapan: json['kelembapan'], 
        angin: json['angin'],
      );
}

Future<List<Weather>> loadWeathers() async {
  final jsonString = await rootBundle.loadString('assets/data/weather.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((item) => Weather.fromJson(item)).toList();
}
