import 'package:flutter/material.dart';

import '../../../../routing/routes.dart';
import '../../../common/kanji_box.dart';

class KanjiRow extends StatelessWidget {
  final List<String> kanji;
  final double fontSize;
  const KanjiRow({
    Key? key,
    required this.kanji,
    this.fontSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kanji:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final k in kanji)
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.kanjiSearch,
                  arguments: k,
                ),
                child: KanjiBox.headline4(
                  context: context,
                  kanji: k,
                ),
              )
          ],
        ),
      ],
    );
  }
}
