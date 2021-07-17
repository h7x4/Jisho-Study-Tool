import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String kanji;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          kanji,
          style: TextStyle(fontSize: 80.0, color: Colors.white),
        ),
      ),
    );
  }

  Header(this.kanji);
}