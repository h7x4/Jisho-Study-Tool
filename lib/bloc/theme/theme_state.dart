part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final bool prefsAreLoaded;

  const ThemeState(this.prefsAreLoaded);

  AppTheme get theme;
}

class LightThemeState extends ThemeState {
  final bool prefsAreLoaded;

  const LightThemeState({this.prefsAreLoaded = false}) : super(prefsAreLoaded);

  @override
  AppTheme get theme => LightTheme();
}

class DarkThemeState extends ThemeState {
  final bool prefsAreLoaded;

  const DarkThemeState({this.prefsAreLoaded = false}) : super(prefsAreLoaded);

  @override
  AppTheme get theme => DarkTheme();
}
