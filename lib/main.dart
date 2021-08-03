import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/view/screens/loading.dart';
import 'package:mdi/mdi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:jisho_study_tool/objectbox.g.dart';

import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:jisho_study_tool/bloc/search/search_bloc.dart';
import 'package:jisho_study_tool/bloc/navigation/navigation_bloc.dart';

import 'package:jisho_study_tool/view/screens/kanji/view.dart';
import 'package:jisho_study_tool/view/screens/history.dart';
import 'package:jisho_study_tool/view/screens/search/view.dart';
import 'package:jisho_study_tool/view/screens/settings.dart';

void main() => runApp(MyApp());

DatabaseBloc _databaseBloc = DatabaseBloc();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Store _store;

  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        getObjectBoxModel(),
        directory: join(dir.path, 'objectbox'),
      );

      _databaseBloc.add(ConnectedToDatabase(_store));
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
    return MaterialApp(
      title: 'Jisho Study Tool',

      // TODO: Add color theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SearchBloc(_databaseBloc)),
          BlocProvider(create: (context) => KanjiBloc(_databaseBloc)),
          BlocProvider(create: (context) => _databaseBloc),
          BlocProvider(create: (context) => NavigationBloc()),
        ],
        child:
            BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
          if (state is DatabaseDisconnected)
            return Container(
              child: LoadingScreen(),
              decoration: BoxDecoration(color: Colors.white),
            );

          return Home();
        }),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        int selectedPage = (state as NavigationPage).pageNum;

        return Scaffold(
          appBar: AppBar(
            title: pages[selectedPage].titleBar,
            centerTitle: true,
          ),
          body: pages[selectedPage].content,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedPage,
            onTap: (int index) =>
                BlocProvider.of<NavigationBloc>(context).add(ChangePage(index)),
            items: pages.map((p) => p.item).toList(),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.blue,
            selectedItemColor: Colors.green,
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
    titleBar: KanjiViewBar(),
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
