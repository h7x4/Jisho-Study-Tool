import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/parser.dart';

class Senses extends StatelessWidget {
  final List<JishoWordSense> senses;
  
  const Senses(this.senses);

  @override
  Widget build(BuildContext context) {
    final List<Widget> senseWidgets =
        senses.asMap().entries.map((e) => _Sense(e.key, e.value)).toList();

    return Container(
        child: Column(
      children: senseWidgets,
    ));
  }
}

class _Sense extends StatelessWidget {
  final int index;
  final JishoWordSense sense;

  const _Sense(this.index, this.sense);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                (index + 1).toString() + '. ',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                sense.partsOfSpeech.join(', '),
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Container(
            child: Row(
              children:[
                Column(
                  children:
                    sense.englishDefinitions.map((def) => Text(def)).toList(),
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ]
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
          ),
        ],
      ),
    );
  }
}
