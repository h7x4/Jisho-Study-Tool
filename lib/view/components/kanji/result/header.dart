import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String kanji;

  const Header(this.kanji);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            kanji,
            style: TextStyle(fontSize: 70.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
