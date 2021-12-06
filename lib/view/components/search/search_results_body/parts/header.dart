import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

class JapaneseHeader extends StatelessWidget {
  final JishoJapaneseWord word;

  const JapaneseHeader({
    required this.word,
    Key? key,
  }) : super(key: key);

  bool get hasFurigana => word.word != null && word.reading != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          // TODO: take a look at this logic
          hasFurigana ? Text(word.reading!) : const Text(''),
          hasFurigana ? Text(word.word!) : Text(word.reading ?? word.word!),
        ],
      ),
    );
  }
}
