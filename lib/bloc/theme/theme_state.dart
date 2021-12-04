part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final bool prefsAreLoaded;

  const ThemeState({required this.prefsAreLoaded});

  AppTheme get theme;
}

class LightThemeState extends ThemeState {
  const LightThemeState({bool prefsAreLoaded = false})
      : super(prefsAreLoaded: prefsAreLoaded);

  @override
  AppTheme get theme => LightTheme();
}

class DarkThemeState extends ThemeState {
  const DarkThemeState({bool prefsAreLoaded = false})
      : super(prefsAreLoaded: prefsAreLoaded);

  @override
  AppTheme get theme => DarkTheme();
}
