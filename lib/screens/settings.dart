import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import '../bloc/theme/theme_bloc.dart';
import '../models/history/search.dart';
import '../settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final Database db = GetIt.instance.get<Database>();

  Future<void> clearHistory(context) async {
    final bool userIsSure = await confirm(context);

    if (userIsSure) {
      await Search.store.delete(db);
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleAutoTheme(bool b) {
    final bool newThemeIsDark = b
        ? WidgetsBinding.instance!.window.platformBrightness == Brightness.dark
        : darkThemeEnabled;

    BlocProvider.of<ThemeBloc>(context)
        .add(SetTheme(themeIsDark: newThemeIsDark));

    setState(() => autoThemeEnabled = b);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final TextStyle _titleTextStyle = TextStyle(
            color:
                state is DarkThemeState ? AppTheme.jishoGreen.background : null,
          );

          return SettingsList(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            sections: <SettingsSection>[
              SettingsSection(
                title: 'Dictionary',
                titleTextStyle: _titleTextStyle,
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    title: 'Use romaji',
                    onToggle: (b) {
                      setState(() => romajiEnabled = b);
                    },
                    switchValue: romajiEnabled,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                ],
              ),
              SettingsSection(
                title: 'Theme',
                titleTextStyle: _titleTextStyle,
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    title: 'Automatically determine theme',
                    onToggle: toggleAutoTheme,
                    switchValue: autoThemeEnabled,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                  SettingsTile.switchTile(
                    title: 'Dark Theme',
                    onToggle: (b) {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(SetTheme(themeIsDark: b));
                      setState(() => darkThemeEnabled = b);
                    },
                    switchValue: darkThemeEnabled,
                    enabled: !autoThemeEnabled,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                ],
              ),
              SettingsSection(
                title: 'Cache',
                titleTextStyle: _titleTextStyle,
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    title: 'Cache grade 1-7 kanji',
                    switchValue: false,
                    onToggle: (v) {},
                    enabled: false,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                  SettingsTile.switchTile(
                    title: 'Cache grade standard kanji',
                    switchValue: false,
                    onToggle: (v) {},
                    enabled: false,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                  SettingsTile.switchTile(
                    title: 'Cache all favourites',
                    switchValue: false,
                    onToggle: (v) {},
                    enabled: false,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                  SettingsTile.switchTile(
                    title: 'Cache all searches',
                    switchValue: false,
                    onToggle: (v) {},
                    enabled: false,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                ],
              ),
              SettingsSection(
                title: 'Data',
                titleTextStyle: _titleTextStyle,
                tiles: <SettingsTile>[
                  SettingsTile(
                    leading: const Icon(Icons.file_download),
                    title: 'Export Data',
                    enabled: false,
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.delete),
                    title: 'Clear History',
                    onPressed: clearHistory,
                    titleTextStyle: const TextStyle(color: Colors.red),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.delete),
                    title: 'Clear Favourites',
                    onPressed: (c) {},
                    titleTextStyle: const TextStyle(color: Colors.red),
                    enabled: false,
                  )
                ],
              ),
            ],
          );
        },
      );
}
