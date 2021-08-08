import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';
import 'package:jisho_study_tool/models/history/search.dart';
import 'package:jisho_study_tool/models/themes/theme.dart';
import 'package:jisho_study_tool/objectbox.g.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late final SharedPreferences prefs;

  bool darkThemeEnabled = false;
  bool autoThemeEnabled = false;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
      _getPrefs();
    });
  }

  /// Get stored preferences and set setting page state accordingly
  void _getPrefs() {
    setState(() {
      darkThemeEnabled = prefs.getBool('darkThemeEnabled') ?? darkThemeEnabled;
      autoThemeEnabled = prefs.getBool('autoThemeEnabled') ?? autoThemeEnabled;
    });
  }

  /// Update stored preferences with values from setting page state
  void _updatePrefs() async {
    await prefs.setBool('darkThemeEnabled', darkThemeEnabled);
    await prefs.setBool('autoThemeEnabled', autoThemeEnabled);
  }

  Widget build(BuildContext context) {
    final TextStyle _titleTextStyle = TextStyle(
        color: BlocProvider.of<ThemeBloc>(context).state is DarkThemeState
            ? AppTheme.jishoGreen.background
            : null);

    return SettingsList(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      sections: [
        SettingsSection(
          title: 'Theme',
          titleTextStyle: _titleTextStyle,
          tiles: [
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
                BlocProvider.of<ThemeBloc>(context).add(SetTheme(themeIsDark: b));
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
          tiles: [
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
          tiles: [
            SettingsTile(
              leading: Icon(Icons.file_download),
              title: 'Export Data',
              enabled: false,
            ),
            SettingsTile(
              leading: Icon(Icons.delete),
              title: 'Clear History',
              onPressed: _clearHistory,
              titleTextStyle: TextStyle(color: Colors.red),
              enabled: false,
            ),
            SettingsTile(
              leading: Icon(Icons.delete),
              title: 'Clear Favourites',
              onPressed: (c) {},
              titleTextStyle: TextStyle(color: Colors.red),
              enabled: false,
            )
          ],
        ),
      ],
    );
  }
}

void _clearHistory(context) async {
  if (await confirm(context)) {
    Store db =
        (BlocProvider.of<DatabaseBloc>(context).state as DatabaseConnected)
            .database;
    // db.box<Search>().query().build().find()
    db.box<Search>().removeAll();
  }
}
