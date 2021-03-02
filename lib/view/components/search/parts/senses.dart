import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/parser.dart';

class Senses extends StatelessWidget {
  final List<JishoWordSense> _senses;
  const Senses(this._senses);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _senseWidgets =
        _senses.map((sense) => _Sense(sense)).toList();

    return Container(
        child: Column(
      children: _senseWidgets,
    ));
  }
}

class _Sense extends StatelessWidget {
  final JishoWordSense _sense;
  const _Sense(this._sense);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            _sense.parts_of_speech.join(', '),
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Column(
            children:
                _sense.english_definitions.map((def) => Text(def)).toList(),
          )
        ],
      ),
    );
  }
}
