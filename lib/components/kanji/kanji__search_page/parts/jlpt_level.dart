
import 'package:flutter/material.dart';

class JlptLevel extends StatelessWidget {
  final String _jlptLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        _jlptLevel,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }

  JlptLevel(this._jlptLevel);
}