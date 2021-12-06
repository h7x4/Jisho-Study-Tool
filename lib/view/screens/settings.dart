import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../../models/history/search.dart';
import '../../models/themes/theme.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SharedPreferences prefs = GetIt.instance.get<SharedPreferences>();

  bool darkThemeEnabled = false;
  bool autoThemeEnabled = false;

  @override
  void initState() {
    super.initState();
    darkThemeEnabled = prefs.getBool('darkThemeEnabled') ?? darkThemeEnabled;
    autoThemeEnabled = prefs.getBool('autoThemeEnabled') ?? autoThemeEnabled;
  }

  /// Update stored preferences with values from setting page state
  Future<void> _updatePrefs() async {
    prefs.setBool('darkThemeEnabled', darkThemeEnabled);
    prefs.setBool('autoThemeEnabled', autoThemeEnabled);
  }

  Future<void> clearHistory(context) async {
    final bool userIsSure = await confirm(context);

    if (userIsSure) {
      final Database db = GetIt.instance.get<Database>();
      await Search.store.delete(db);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle _titleTextStyle = TextStyle(
      color: BlocProvider.of<ThemeBloc>(context).state is DarkThemeState
          ? AppTheme.jishoGreen.background
          : null,
    );

    return SettingsList(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      sections: <SettingsSection>[
        SettingsSection(
          title: 'Theme',
          titleTextStyle: _titleTextStyle,
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              title: 'Automatically determine theme',
              onToggle: (b) {
                setState(() {
                  autoThemeEnabled = b;
                });
                _updatePrefs();
              },
              switchValue: autoThemeEnabled,
              enabled: false,
              switchActiveColor: AppTheme.jishoGreen.background,
            ),
            SettingsTile.switchTile(
              title: 'Dark Theme',
              onToggle: (b) {
                BlocProvider.of<ThemeBloc>(context)
                    .add(SetTheme(themeIsDark: b));
                setState(() {
                  darkThemeEnabled = b;
                });
                _updatePrefs();
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
            const SettingsTile(
              leading: Icon(Icons.file_download),
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
  }
}
