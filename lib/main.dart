import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/theme/theme_bloc.dart';
import 'router.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    setupDatabase(),
    setupSharedPreferences(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
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
