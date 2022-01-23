import 'package:flutter/material.dart';

import '../../../../../models/themes/theme.dart';
import '../../../../../routing/routes.dart';
import 'search_chip.dart';

class Antonyms extends StatelessWidget {
  final List<String> antonyms;
  final ColorSet colors;

  const Antonyms({
    Key? key,
    required this.antonyms,
    this.colors = const ColorSet(
      foreground: Colors.white,
      background: Colors.blue,
    ),
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
          children: [
            for (final antonym in antonyms)
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.search,
                  arguments: antonym,
                ),
                child: SearchChip(
                  text: antonym,
                  colors: colors,
                ),
              ),
          ],
        )
      ],
    );
  }
}
