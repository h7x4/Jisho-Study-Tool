import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/parser.dart';

class Senses extends StatelessWidget {
  final List<JishoWordSense> senses;

  const Senses({
    required this.senses,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> senseWidgets =
        senses.asMap().entries.map((e) => _Sense(e.key, e.value)).toList();

    return Column(
      children: senseWidgets,
    );
  }
}

class _Sense extends StatelessWidget {
  final int index;
  final JishoWordSense sense;

  const _Sense(this.index, this.sense);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '${index + 1}. ',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              sense.partsOfSpeech.join(', '),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    sense.englishDefinitions.map((def) => Text(def)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
