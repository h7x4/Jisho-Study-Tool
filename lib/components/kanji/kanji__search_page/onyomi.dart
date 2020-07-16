import 'package:flutter/material.dart';

class Onyomi extends StatelessWidget {
  final List<String> _onyomi;

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
        children: _onyomi.map((onyomi) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: Text(
              onyomi,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        }).toList(),
      ),
    );
  }

  Onyomi(this._onyomi);
}
