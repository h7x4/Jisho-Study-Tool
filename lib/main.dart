import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';
import 'package:jisho_study_tool/router.dart';
import 'package:jisho_study_tool/view/components/common/splash.dart';
import 'package:mdi/mdi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:jisho_study_tool/objectbox.g.dart';

import 'package:jisho_study_tool/bloc/database/database_bloc.dart';

import 'package:jisho_study_tool/view/screens/search/kanji_view.dart';
import 'package:jisho_study_tool/view/screens/history.dart';
import 'package:jisho_study_tool/view/screens/search/search_view.dart';
import 'package:jisho_study_tool/view/screens/settings.dart';

import 'models/themes/theme.dart';

void main() => runApp(MyApp());

DatabaseBloc _databaseBloc = DatabaseBloc();

class MyApp extends StatefulWidget {
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
    _databaseBloc.add(DisconnectedFromDatabase());
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
            return SplashScreen();

          return MaterialApp(
            title: 'Jisho Study Tool',
            theme: themeState.theme.getMaterialTheme(),
            initialRoute: '/',
            onGenerateRoute: PageRouter.generateRoute,
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
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
                child: Image.asset(
                    'assets/images/denshi_jisho_background_overlay.png'),
                right: 30,
                left: 100,
                bottom: 30,
              ),
              pages[pageNum].content,
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: AppTheme.jishoGreen.background,
            currentIndex: pageNum,
            onTap: (int index) => setState(() {
              this.pageNum = index;
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
  _Page(
    content: SearchView(),
    titleBar: Text('Search'),
    item: BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(Icons.search),
    ),
  ),
  _Page(
    content: KanjiView(),
    titleBar: Text('Kanji'),
    item: BottomNavigationBarItem(
        label: 'Kanji', icon: Icon(Mdi.ideogramCjk, size: 30)),
  ),
  _Page(
    content: HistoryView(),
    titleBar: Text("History"),
    item: BottomNavigationBarItem(
      label: 'History',
      icon: Icon(Icons.history),
    ),
  ),
  _Page(
    content: Container(),
    titleBar: Text("Saved"),
    item: BottomNavigationBarItem(
      label: 'Saved',
      icon: Icon(Icons.bookmark),
    ),
  ),
  _Page(
    content: SettingsView(),
    titleBar: Text("Settings"),
    item: BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(Icons.settings),
    ),
  ),
];
