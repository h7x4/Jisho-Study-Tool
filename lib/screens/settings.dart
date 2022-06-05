import 'dart:io';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:mdi/mdi.dart';

import '../bloc/theme/theme_bloc.dart';
import '../components/common/denshi_jisho_background.dart';
import '../data/database.dart';
import '../data/export.dart';
import '../data/import.dart';
import '../routing/routes.dart';
import '../services/open_webpage.dart';
import '../services/snackbar.dart';
import '../settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool dataExportIsLoading = false;
  bool dataImportIsLoading = false;

  Future<void> clearHistory(context) async {
    final historyCount = (await db().query(
      TableNames.historyEntry,
      columns: ['COUNT(*) AS count'],
    ))[0]['count']! as int;

    final bool userIsSure = await confirm(
      context,
      content: Text(
        'Are you sure that you want to delete $historyCount entries?',
      ),
    );
    if (!userIsSure) return;

    await db().delete(TableNames.historyEntry);
    showSnackbar(context, 'Cleared history');
  }

  Future<void> clearAll(context) async {
    final bool userIsSure = await confirm(context);
    if (!userIsSure) return;

    await resetDatabase();
    showSnackbar(context, 'Cleared everything');
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleAutoTheme(bool b) {
    final bool newThemeIsDark = b
        ? WidgetsBinding.instance.window.platformBrightness == Brightness.dark
        : darkThemeEnabled;

    BlocProvider.of<ThemeBloc>(context)
        .add(SetTheme(themeIsDark: newThemeIsDark));

    setState(() => autoThemeEnabled = b);
  }

  Future<void> changeFont(context) async {
    final int? i = await _chooseFromList(
      list: [for (final font in JapaneseFont.values) font.name],
      chosen: japaneseFont.index,
    )(context);
    if (i != null)
      setState(() {
        japaneseFont = JapaneseFont.values[i];
      });
  }

  /// Can assume Android for time being
  Future<void> exportHandler(context) async {
    setState(() => dataExportIsLoading = true);
    final path = await exportData();
    setState(() => dataExportIsLoading = false);
    showSnackbar(context, 'Data exported to $path');
  }

  /// Can assume Android for time being
  Future<void> importHandler(context) async {
    setState(() => dataImportIsLoading = true);

    final path = await FilePicker.platform.getDirectoryPath();
    await importData(Directory(path!));

    setState(() => dataImportIsLoading = false);
    showSnackbar(context, 'Data imported successfully');
  }

  Future<int?> Function(BuildContext) _chooseFromList({
    required List<String> list,
    int? chosen,
    String? title,
  }) =>
      (context) => Navigator.push<int>(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(title: title == null ? null : Text(title)),
                body: DenshiJishoBackground(
                  child: ListView.builder(
                    itemBuilder: (context, i) => ListTile(
                      title: Text(list[i]),
                      trailing: (chosen != null && chosen == i)
                          ? const Icon(Icons.check)
                          : null,
                      onTap: () => Navigator.pop(context, i),
                    ),
                    itemCount: list.length,
                  ),
                ),
              ),
            ),
          );

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final TextStyle _titleTextStyle = TextStyle(
            color:
                state is DarkThemeState ? AppTheme.jishoGreen.background : null,
          );

          const SettingsTileTheme theme = SettingsTileTheme(
            horizontalTitleGap: 0,
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
                    leading: const Icon(Mdi.alphabetical),
                    onToggle: (b) => setState(() => romajiEnabled = b),
                    switchValue: romajiEnabled,
                    theme: theme,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                  SettingsTile.switchTile(
                    title: 'Extensive search',
                    leading: const Icon(Icons.downloading),
                    onToggle: (b) => setState(() => extensiveSearchEnabled = b),
                    switchValue: extensiveSearchEnabled,
                    theme: theme,
                    switchActiveColor: AppTheme.jishoGreen.background,
                    // subtitle:
                    //     'Gathers extra data when searching for words, at the expense of having to wait for extra word details.',
                    // subtitleWidget:
                    trailing: const Icon(Icons.info),
                    subtitleMaxLines: 3,
                  ),
                  SettingsTile(
                    title: 'Japanese font',
                    leading: const Icon(Icons.format_size),
                    onPressed: changeFont,
                    theme: theme,
                    trailing: Text(japaneseFont.name),
                    // subtitle:
                    //     'Which font to use for japanese text. This might be useful if your phone shows kanji with a Chinese font.',
                    subtitleMaxLines: 3,
                  ),
                ],
              ),

              SettingsSection(
                title: 'Theme',
                titleTextStyle: _titleTextStyle,
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    title: 'Automatic theme',
                    leading: const Icon(Icons.brightness_auto),
                    onToggle: toggleAutoTheme,
                    switchValue: autoThemeEnabled,
                    theme: theme,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                  SettingsTile.switchTile(
                    title: 'Dark Theme',
                    leading: const Icon(Icons.dark_mode),
                    onToggle: (b) {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(SetTheme(themeIsDark: b));
                      setState(() => darkThemeEnabled = b);
                    },
                    switchValue: darkThemeEnabled,
                    enabled: !autoThemeEnabled,
                    theme: theme,
                    switchActiveColor: AppTheme.jishoGreen.background,
                  ),
                ],
              ),

              // TODO: This will be left commented until caching is implemented
              // SettingsSection(
              //   title: 'Cache',
              //   titleTextStyle: _titleTextStyle,
              //   tiles: <SettingsTile>[
              //     SettingsTile.switchTile(
              //       title: 'Cache grade 1-7 kanji',
              //       switchValue: false,
              //       onToggle: (v) {},
              //       enabled: false,
              //       switchActiveColor: AppTheme.jishoGreen.background,
              //     ),
              //     SettingsTile.switchTile(
              //       title: 'Cache grade standard kanji',
              //       switchValue: false,
              //       onToggle: (v) {},
              //       enabled: false,
              //       switchActiveColor: AppTheme.jishoGreen.background,
              //     ),
              //     SettingsTile.switchTile(
              //       title: 'Cache all favourites',
              //       switchValue: false,
              //       onToggle: (v) {},
              //       enabled: false,
              //       switchActiveColor: AppTheme.jishoGreen.background,
              //     ),
              //     SettingsTile.switchTile(
              //       title: 'Cache all searches',
              //       switchValue: false,
              //       onToggle: (v) {},
              //       enabled: false,
              //       switchActiveColor: AppTheme.jishoGreen.background,
              //     ),
              //   ],
              // ),

              SettingsSection(
                title: 'Data',
                titleTextStyle: _titleTextStyle,
                tiles: <SettingsTile>[
                  SettingsTile(
                    leading: const Icon(Icons.file_upload),
                    title: 'Import Data',
                    onPressed: importHandler,
                    enabled: Platform.isAndroid,
                    subtitle:
                        Platform.isAndroid ? null : 'Not available on iOS yet',
                    subtitleWidget: dataImportIsLoading
                        ? const LinearProgressIndicator()
                        : null,
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.file_download),
                    title: 'Export Data',
                    onPressed: exportHandler,
                    enabled: Platform.isAndroid,
                    subtitle:
                        Platform.isAndroid ? null : 'Not available on iOS yet',
                    subtitleWidget: dataExportIsLoading
                        ? const LinearProgressIndicator()
                        : null,
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
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.delete),
                    title: 'Clear Everything',
                    onPressed: clearAll,
                    titleTextStyle: const TextStyle(color: Colors.red),
                  ),
                ],
              ),

              SettingsSection(
                title: 'Info',
                titleTextStyle: _titleTextStyle,
                tiles: <SettingsTile>[
                  SettingsTile(
                    leading: const Icon(Icons.info),
                    title: 'About',
                    onPressed: (c) =>
                        Navigator.pushNamed(context, Routes.about),
                  ),
                  SettingsTile(
                    leading: Image.asset(
                      'assets/images/logo/logo_icon_transparent_green.png',
                      width: 30,
                    ),
                    title: 'Jisho',
                    onPressed: (c) => open_webpage('https://jisho.org/about'),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.copyright),
                    title: 'Licenses',
                    onPressed: (c) =>
                        Navigator.pushNamed(context, Routes.aboutLicenses),
                  ),
                ],
              )
            ],
          );
        },
      );
}
