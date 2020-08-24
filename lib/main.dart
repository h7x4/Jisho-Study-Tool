import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:jisho_study_tool/screens/kanji_search.dart';
import 'package:jisho_study_tool/screens/history.dart';
import 'package:jisho_study_tool/screens/search.dart';

import 'bloc/search/search_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: pages[_selectedPage].titleBar,
        centerTitle: true,
      ),
      body: pages[_selectedPage].content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
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
    title: Text('Search'),
    icon: Icon(Icons.search),
  ),
  BottomNavigationBarItem(
    title: Text('Kanji'),
    icon: Text(
      '漢',
      style: TextStyle(fontSize: 18),
    ),
  ),
  BottomNavigationBarItem(
    title: Text('History'),
    icon: Icon(Icons.bookmark),
  ),
  BottomNavigationBarItem(
    title: Text('Memorize'),
    icon: Icon(Icons.local_offer),
  ),
  BottomNavigationBarItem(
    title: Text('Settings'),
    icon: Icon(Icons.settings),
  ),
];

class Page {
  Widget content;
  Widget titleBar;

  Page({
    this.content,
    this.titleBar,
  });
}

final List<Page> pages = [
  Page(content: SearchView(), titleBar: Text('Search')),
  Page(
    content: KanjiView(),
    titleBar: KanjiViewBar(),
  ),
  Page(
    content: HistoryView(),
    titleBar: Text("History"),
  ),
  Page(
    content: Container(),
    titleBar: Text("Memorization"),
  ),
  Page(
    content: Container(),
    titleBar: Text("Settings"),
  ),
];
