
import 'package:flutter/material.dart';

import 'bloc/theme/theme_bloc.dart';
import 'data/database.dart';
import 'routing/router.dart';
import 'services/licenses.dart';
import 'services/preferences.dart';
import 'settings.dart';

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
