part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  const ThemeEvent();
}

class SetTheme extends ThemeEvent {
  final bool themeIsDark;

  const SetTheme({required this.themeIsDark});
}
