part of './theme.dart';

class DarkTheme extends AppTheme {
  ColorSet get kanjiResultColor => const ColorSet(
        foreground: Colors.white,
        background: Colors.green,
      );

  ColorSet get onyomiColor => const ColorSet(
        foreground: Colors.white,
        background: Colors.orange,
      );

  ColorSet get kunyomiColor => const ColorSet(
        foreground: Colors.white,
        background: Colors.lightBlue,
      );

  Color get foreground => Colors.black;
  Color get background => Colors.white;

  ColorSet get menuGreyLight => ColorSet(
        foreground: Colors.white,
        background: Colors.grey.shade700,
      );

  ColorSet get menuGreyNormal => ColorSet(
        foreground: Colors.white,
        background: Colors.grey,
      );

  ColorSet get menuGreyDark => ColorSet(
        foreground: Colors.black,
        background: Colors.grey.shade300,
      );

  @override
  ThemeData getMaterialTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: createMaterialColor(AppTheme.jishoGreen.background),
    );
  }
}
