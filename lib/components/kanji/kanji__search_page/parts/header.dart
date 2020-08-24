import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String _kanji;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          _kanji,
          style: TextStyle(fontSize: 80.0, color: Colors.white),
        ),
      ),
    );
  }

  Header(this._kanji);
}