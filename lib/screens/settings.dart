import 'dart:convert';
import 'dart:io';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:mdi/mdi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/sembast_import_export.dart';

import '../bloc/theme/theme_bloc.dart';
import '../components/common/denshi_jisho_background.dart';
import '../models/history/search.dart';
import '../routing/routes.dart';
import '../services/database.dart';
import '../services/open_webpage.dart';
import '../services/snackbar.dart';
import '../settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final Database db = GetIt.instance.get<Database>();
  bool dataExportIsLoading = false;
  bool dataImportIsLoading = false;

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
  Future<void> exportData(context) async {
    setState(() => dataExportIsLoading = true);

    final path = (await getExternalStorageDirectory())!;
    final dbData = await exportDatabase(db);
    final file = File('${path.path}/jisho_data.json');
    file.createSync(recursive: true);
    await file.writeAsString(jsonEncode(dbData));

    setState(() => dataExportIsLoading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Data exported to ${file.path}')));
  }

  /// Can assume Android for time being
  Future<void> importData(context) async {
    setState(() => dataImportIsLoading = true);

    final path = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final file = File(path!.files[0].path!);

    final List<Search> prevSearches = (await Search.store.find(db))
        .map((e) => Search.fromJson(e.value! as Map<String, Object?>))
        .toList();
    late final List<Search> importedSearches;
    try {
      importedSearches = ((((jsonDecode(await file.readAsString())
                  as Map<String, Object?>)['stores']! as List)
              .map((e) => e as Map)
              .where((e) => e['name'] == 'search')
              .first)['values'] as List)
          .map((item) => Search.fromJson(item))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      showSnackbar(
        context,
        "Couldn't read file. Did you choose the right one?",
      );
      return;
    }

    final List<Search> mergedSearches =
        mergeSearches(prevSearches, importedSearches);

    // print(mergedSearches);

    await GetIt.instance.get<Database>().close();
    GetIt.instance.unregister<Database>();

    final importedDb = await importDatabase(
      {
        'sembast_export': 1,
        'version': 1,
        'stores': [
          {
            'name': 'search',
            'keys': [for (var i = 1; i <= mergedSearches.length; i++) i],
            'values': mergedSearches.map((e) => e.toJson()).toList(),
          }
        ]
      },
      databaseFactoryIo,
      await databasePath(),
    );
    GetIt.instance.registerSingleton<Database>(importedDb);

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
                    onPressed: importData,
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
                  )
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
