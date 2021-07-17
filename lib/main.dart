import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:jisho_study_tool/view/screens/kanji/view.dart';
import 'package:jisho_study_tool/view/screens/history.dart';
import 'package:jisho_study_tool/view/screens/search/view.dart';

import 'bloc/search/search_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jisho Study Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SearchBloc()),
          BlocProvider(create: (context) => KanjiBloc()),
        ],
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: pages[selectedPage].titleBar,
        centerTitle: true,
      ),
      body: pages[selectedPage].content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
        items: navBar,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.blue,
        selectedItemColor: Colors.green,
      ),
    );
  }
}

final List<BottomNavigationBarItem> navBar = [
  BottomNavigationBarItem(
    label: 'Search',
    icon: Icon(Icons.search),
  ),
  BottomNavigationBarItem(
      label: 'Kanji',
      icon: Icon(
        Mdi.ideogramCjk,
        size: 30,
      )),
  BottomNavigationBarItem(
    label: 'History',
    icon: Icon(Icons.history),
  ),
  BottomNavigationBarItem(
    label: 'Memorize',
    icon: Icon(Icons.bookmark),
  ),
  BottomNavigationBarItem(
    label: 'Settings',
    icon: Icon(Icons.settings),
  ),
];

class _Page {
  Widget content;
  Widget titleBar;

  _Page({
    this.content,
    this.titleBar,
  });
}

final List<_Page> pages = [
  _Page(
    content: SearchView(),
    titleBar: Text('Search'),
  ),
  _Page(
    content: KanjiView(),
    titleBar: KanjiViewBar(),
  ),
  _Page(
    content: HistoryView(),
    titleBar: Text("History"),
  ),
  _Page(
    content: Container(),
    titleBar: Text("Memorization"),
  ),
  _Page(
    content: Container(),
    titleBar: Text("Settings"),
  ),
];
