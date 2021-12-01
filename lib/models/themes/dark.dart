part of './theme.dart';

class DarkTheme extends AppTheme {
  @override
  ColorSet get kanjiResultColor => const ColorSet(
        foreground: Colors.white,
        background: Colors.green,
      );

  @override
  ColorSet get onyomiColor => const ColorSet(
        foreground: Colors.white,
        background: Colors.orange,
      );

  @override
  ColorSet get kunyomiColor => const ColorSet(
        foreground: Colors.white,
        background: Colors.lightBlue,
      );

  @override
  Color get foreground => Colors.black;
  @override
  Color get background => Colors.white;

  @override
  ColorSet get menuGreyLight => ColorSet(
        foreground: Colors.white,
        background: Colors.grey.shade700,
      );

  @override
  ColorSet get menuGreyNormal => const ColorSet(
        foreground: Colors.white,
        background: Colors.grey,
      );

  @override
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
