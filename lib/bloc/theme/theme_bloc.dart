import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jisho_study_tool/models/themes/theme.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:jisho_study_tool/models/themes/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool prefsAreLoaded = false;

  ThemeBloc() : super(LightThemeState()) {
    SharedPreferences.getInstance().then((prefs) {
      this.prefsAreLoaded = true;
      this.add(
        SetTheme(
          themeIsDark: prefs.getBool('darkThemeEnabled') ?? false,
        ),
      );
    });
  }

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is SetTheme)
      yield event.themeIsDark
          ? DarkThemeState(prefsAreLoaded: prefsAreLoaded)
          : LightThemeState(prefsAreLoaded: prefsAreLoaded);
  }
}
