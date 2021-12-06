import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/themes/theme.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:jisho_study_tool/models/themes/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const LightThemeState()) {
    on<SetTheme>(
      (event, emit) => emit(
        event.themeIsDark ? const DarkThemeState() : const LightThemeState(),
      ),
    );

    add(
      SetTheme(
        themeIsDark: GetIt.instance
                .get<SharedPreferences>()
                .getBool('darkThemeEnabled') ??
            false,
      ),
    );
  }
}
