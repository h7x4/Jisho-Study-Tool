import 'package:flutter/material.dart';
import '../../../components/drawing_board/drawing_board.dart';

class KanjiDrawingSearch extends StatelessWidget {
  const KanjiDrawingSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draw a kanji')),
      body: Column(
        children: [
          Expanded(child: Column()),
          DrawingBoard(
            onlyOneCharacterSuggestions: true,
            onSuggestionChosen: (suggestion) => Navigator.popAndPushNamed(
              context,
              '/kanjiSearch',
              arguments: suggestion,
            ),
          ),
        ],
      ),
    );
  }
}
