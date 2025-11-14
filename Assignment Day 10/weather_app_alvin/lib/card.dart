import 'package:flutter/material.dart';
import 'theme_data/theme_data.dart';

Widget weatherInfoBox({
  required BuildContext context,
  required String uvIndex,
  required String humidity,
  required String wind,
  required Color textColor,
}) {
  final double boxWidth = MediaQuery.of(context).size.width * 0.75;

  return SizedBox(
    height: 180, // Tinggi area Stack
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // BACK CARD
        Positioned(
          child: Container(
            height: 120,
            width: boxWidth,
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
            width: boxWidth,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("UV Index",
                        style: customTheme.textTheme.titleMedium!
                            .copyWith(color: textColor)),
                    const SizedBox(height: 6),
                    Text(uvIndex,
                        style: customTheme.textTheme.bodyMedium!
                            .copyWith(color: textColor)),
                  ],
                ),
                Column(
                  children: [
                    Text("Humidity",
                        style: customTheme.textTheme.titleMedium!
                            .copyWith(color: textColor)),
                    const SizedBox(height: 6),
                    Text(humidity,
                        style: customTheme.textTheme.bodyMedium!
                            .copyWith(color: textColor)),
                  ],
                ),
                Column(
                  children: [
                    Text("Wind",
                        style: customTheme.textTheme.titleMedium!
                            .copyWith(color: textColor)),
                    const SizedBox(height: 6),
                    Text(wind,
                        style: customTheme.textTheme.bodyMedium!
                            .copyWith(color: textColor)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
