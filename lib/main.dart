import 'package:flutter/material.dart';
import 'package:jisho_study_tool/screens/kanji_search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
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
          title: Text(pages[_selectedPage].title),
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

List<BottomNavigationBarItem> navBar = [
  BottomNavigationBarItem(
    title: Text('Search'),
    icon: Icon(Icons.search)
  ),
  BottomNavigationBarItem(
    title: Text('Kanji'),
    icon: Text(
      '漢',
      style: TextStyle(
        fontSize: 18
      ),
    )
  ),
  BottomNavigationBarItem(
    title: Text('Memorize'),
    icon: Icon(Icons.local_offer)
  ),
  BottomNavigationBarItem(
    title: Text('Settings'),
    icon: Icon(Icons.settings)
  ),
];

class Page {
  String title;
  Widget content;

  Page({
    this.title,
    this.content
  });
}

List<Page> pages = [
  Page(
    title: "Search",
    content: Container()
  ),
  Page(
    title: "Kanji",
    content: KanjiSearch()
  ),
  Page(
    title: "Memorization",
    content: Container()
  ),
  Page(
    title: "Settings",
    content: Container()
  ),
];