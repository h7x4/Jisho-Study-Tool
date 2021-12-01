import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/database/database_bloc.dart';
import 'bloc/theme/theme_bloc.dart';
import 'models/themes/theme.dart';
import 'objectbox.g.dart';
import 'router.dart';
import 'view/components/common/splash.dart';
import 'view/screens/history.dart';
import 'view/screens/search/kanji_view.dart';
import 'view/screens/search/search_view.dart';
import 'view/screens/settings.dart';

void main() => runApp(const MyApp());

DatabaseBloc _databaseBloc = DatabaseBloc();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Store _store;
  bool dbConnected = false;

  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        getObjectBoxModel(),
        directory: join(dir.path, 'objectbox'),
      );

      _databaseBloc.add(ConnectedToDatabase(_store));
      setState(() {
        dbConnected = true;
      });
    });
  }

  @override
  void dispose() {
    _store.close();
    _databaseBloc.add(const DisconnectedFromDatabase());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _databaseBloc),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          if (!(dbConnected && themeState.prefsAreLoaded))
            return const SplashScreen();

          return MaterialApp(
            title: 'Jisho Study Tool',
            theme: themeState.theme.getMaterialTheme(),
            initialRoute: '/',
            onGenerateRoute: generateRoute,
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageNum = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          appBar: AppBar(
            title: pages[pageNum].titleBar,
            centerTitle: true,
            backgroundColor: AppTheme.jishoGreen.background,
            foregroundColor: AppTheme.jishoGreen.foreground,
          ),
          body: Stack(
            children: [
              Positioned(
                right: 30,
                left: 100,
                bottom: 30,
                child: Image.asset(
                  'assets/images/denshi_jisho_background_overlay.png',
                ),
              ),
              pages[pageNum].content,
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: AppTheme.jishoGreen.background,
            currentIndex: pageNum,
            onTap: (index) => setState(() {
              pageNum = index;
            }),
            items: pages.map((p) => p.item).toList(),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: themeState.theme.menuGreyDark.background,
          ),
        );
      },
    );
  }
}

class _Page {
  final Widget content;
  final Widget titleBar;
  final BottomNavigationBarItem item;

  const _Page({
    required this.content,
    required this.titleBar,
    required this.item,
  });
}

final List<_Page> pages = [
  const _Page(
    content: SearchView(),
    titleBar: Text('Search'),
    item: BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(Icons.search),
    ),
  ),
  const _Page(
    content: KanjiView(),
    titleBar: Text('Kanji'),
    item: BottomNavigationBarItem(
      label: 'Kanji',
      icon: Icon(Mdi.ideogramCjk, size: 30),
    ),
  ),
  const _Page(
    content: HistoryView(),
    titleBar: Text('History'),
    item: BottomNavigationBarItem(
      label: 'History',
      icon: Icon(Icons.history),
    ),
  ),
  _Page(
    content: Container(),
    titleBar: const Text('Saved'),
    item: const BottomNavigationBarItem(
      label: 'Saved',
      icon: Icon(Icons.bookmark),
    ),
  ),
  const _Page(
    content: SettingsView(),
    titleBar: Text('Settings'),
    item: BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(Icons.settings),
    ),
  ),
];
