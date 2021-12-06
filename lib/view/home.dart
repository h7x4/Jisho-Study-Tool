import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import '../bloc/theme/theme_bloc.dart';
import 'screens/history.dart';
import 'screens/search/kanji_view.dart';
import 'screens/search/search_view.dart';
import 'screens/settings.dart';

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

  List<_Page> get pages => [
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
