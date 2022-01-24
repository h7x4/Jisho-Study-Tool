import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/theme/theme_bloc.dart';
import 'routing/router.dart';
import 'settings.dart';

Future<void> setupDatabase() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  if (!appDocDir.existsSync()) appDocDir.createSync(recursive: true);
  final Database database =
      await databaseFactoryIo.openDatabase(join(appDocDir.path, 'sembast.db'));
  GetIt.instance.registerSingleton<Database>(database);
}

Future<void> setupSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(prefs);
}

void registerExtraLicenses() => LicenseRegistry.addLicense(() async* {
      final jsonString = await rootBundle.loadString('assets/licenses.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      for (final license in jsonData.entries)
        yield LicenseEntryWithLineBreaks(
          [license.key],
          await rootBundle.loadString(license.value as String),
        );
    });

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    setupDatabase(),
    setupSharedPreferences(),
  ]);

  registerExtraLicenses();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final ThemeBloc themeBloc = ThemeBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (autoThemeEnabled) {
      final themeIsDark =
          WidgetsBinding.instance?.window.platformBrightness == Brightness.dark;
      themeBloc.add(SetTheme(themeIsDark: themeIsDark));
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => themeBloc),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) => MaterialApp(
          title: 'Jisho Study Tool',
          theme: themeState.theme.getMaterialTheme(),
          initialRoute: '/',
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
