import 'package:flutter/material.dart';

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
          title: Text('Jisho Study Tool')
        ),
        body: Container(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
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
              icon: Icon(Icons.book)
            ),
            BottomNavigationBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings)
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.blue,
          selectedItemColor: Colors.green,
        ),
      );
    }

}