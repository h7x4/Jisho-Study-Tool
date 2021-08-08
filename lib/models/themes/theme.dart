import 'package:flutter/material.dart';

part 'light.dart';
part 'dark.dart';

abstract class AppTheme {

  static const ColorSet jishoGreen = ColorSet(
    foreground: Colors.white,
    background: Color(0xFF3EDD00),
  );

  static const Color jishoGrey = Color(0xFF5A5A5B);

  static const ColorSet jishoLabel = ColorSet(
    foreground: Colors.white,
    background: Color(0xFF909DC0),
  );

  static const ColorSet jishoCommon = ColorSet(
    foreground: Colors.white,
    background: Color(0xFF8ABC83),
  );

  ColorSet get kanjiResultColor;

  ColorSet get onyomiColor;
  ColorSet get kunyomiColor;

  Color get foreground;
  Color get background;

  ColorSet get menuGreyLight;
  ColorSet get menuGreyNormal;
  ColorSet get menuGreyDark;

  ThemeData getMaterialTheme();
}

class ColorSet {
  final Color foreground;
  final Color background;

  const ColorSet({
    required this.foreground,
    required this.background,
  });
}

/// Source: https://blog.usejournal.com/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}