import 'package:flutter/material.dart';
import 'theme_data/theme_data.dart';

Widget weatherInfoBox({
  required BuildContext context,
  required String uvIndex,
  required String humidity,
  required String wind,
  required Color textColor,
}) {
  final width = MediaQuery.of(context).size.width * 0.8;

  return SizedBox(
    height: 180,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          child: Container(
            height: 120,
            width: width-4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.40),
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),

        Positioned(
          top: 20,
          left: 20,
          child: Container(
            width: width-4,
            height:120,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              children: [
                Expanded(child: _item("UV Index", uvIndex, textColor)),
                Expanded(child: _item("Humidity", humidity, textColor)),
                Expanded(child: _item("Wind", wind, textColor)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _item(String label, String value, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        textAlign: TextAlign.center,
        style: customTheme.textTheme.titleMedium!.copyWith(color: color),
        overflow: TextOverflow.ellipsis, // Prevent text overflow
      ),
      const SizedBox(height: 6),
      Text(
        value,
        style: customTheme.textTheme.bodyMedium!.copyWith(color: color),
      ),
    ],
  );
}
