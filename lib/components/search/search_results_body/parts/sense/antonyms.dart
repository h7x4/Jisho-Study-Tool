import 'package:flutter/material.dart';

import '../../../../../models/themes/theme.dart';
import 'search_chip.dart';

class Antonyms extends StatelessWidget {
  final List<String> antonyms;

  const Antonyms({
    Key? key,
    required this.antonyms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Antonyms:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: antonyms
              .map(
                (a) => SearchChip(
                  text: a,
                  colors: const ColorSet(
                    foreground: Colors.white,
                    background: Colors.blue,
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
