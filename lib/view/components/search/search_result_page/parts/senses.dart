import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/parser.dart';

class Senses extends StatelessWidget {
  final List<JishoWordSense> senses;
  const Senses(this.senses);

  @override
  Widget build(BuildContext context) {
    final List<Widget> senseWidgets =
        senses.map((sense) => _Sense(sense)).toList();

    return Container(
        child: Column(
      children: senseWidgets,
    ));
  }
}

class _Sense extends StatelessWidget {
  final JishoWordSense sense;
  const _Sense(this.sense);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            sense.parts_of_speech.join(', '),
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Column(
            children:
                sense.english_definitions.map((def) => Text(def)).toList(),
          )
        ],
      ),
    );
  }
}
