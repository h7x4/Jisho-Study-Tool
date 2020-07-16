import 'package:flutter/material.dart';

class Meaning extends StatelessWidget {
  String _meaning;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: Wrap(
        runSpacing: 10.0,
        children: _meaning
            .split(',')
            .map((meaning) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(meaning),
                ))
            .toList(),
      ),
    );
  }

  Meaning(this._meaning);
}
