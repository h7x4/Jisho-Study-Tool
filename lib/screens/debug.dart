import 'package:flutter/material.dart';

import '../components/common/kanji_box.dart';
// import '../components/drawing_board/drawing_board.dart';
// import '../components/library/add_to_library_dialog.dart';

class DebugView extends StatelessWidget {
  const DebugView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Center(child: KanjiBox(kanji: '漢'));
    return ListView(
      children: [
        Row(
          children: [
            KanjiBox.withPadding(kanji: '漢', padding: 5),
            KanjiBox.withFontSize(kanji: '漢', fontSize: 20),
            const KanjiBox.withFontSizeAndPadding(
              kanji: '漢',
              fontSize: 40,
              padding: 10,
            ),
            KanjiBox.withFontSize(kanji: '漢', fontSize: 40),
            KanjiBox.withPadding(kanji: '漢', padding: 10),
          ],
        ),
        const Divider(),
        KanjiBox.expanded(kanji: '彼', ratio: 1),
        const Divider(),
        KanjiBox.expanded(kanji: '例')
      ],
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: const [
    //   ElevatedButton(
    //     onPressed: () => showAddToLibraryDialog(
    //       context: context,
    //       entryText: 'lol',
    //     ),
    //     child: const Text('Add entry to list'),
    //   ),
    //   DrawingBoard(
    //     allowHiragana: true,
    //     allowKatakana: true,
    //     allowOther: true,
    //     onSuggestionChosen: (s) => ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Chose: $s'),
    //         duration: const Duration(milliseconds: 600),
    //       ),
    //     ),
    //   ),
    //   ],
    // );
  }
}
