part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  const ThemeState();

  AppTheme get theme;
}

class LightThemeState extends ThemeState {
  const LightThemeState();

  @override
  AppTheme get theme => const LightTheme();
}

class DarkThemeState extends ThemeState {
  const DarkThemeState();

  @override
  AppTheme get theme => const DarkTheme();
}
