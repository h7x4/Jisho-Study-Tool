import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/themes/theme.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:jisho_study_tool/models/themes/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool prefsAreLoaded = false;

  ThemeBloc() : super(const LightThemeState()) {
    SharedPreferences.getInstance().then((prefs) {
      prefsAreLoaded = true;
      add(
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
