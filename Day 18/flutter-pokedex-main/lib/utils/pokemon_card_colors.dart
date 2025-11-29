import 'package:flutter/material.dart';

const List<Color> kPokemonCardColors = [
  Color(0xFF60D394),
  Color(0xFFFF8C7A),
  Color(0xFF76BDFE),
  Color(0xFFFFD76F),
  Color(0xFF5DB08C),
  Color(0xFF5A9DF2),
  Color(0xFFFF6B81),
  Color(0xFF4D8ED4),
];

Color cardColorForName(String name) {
  final safeHash = name.hashCode & 0x7fffffff;
  return kPokemonCardColors[safeHash % kPokemonCardColors.length];
}
