import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

class Radical extends StatelessWidget {
  final jisho.Radical _radical;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        _radical.symbol,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }

  Radical(this._radical);
}