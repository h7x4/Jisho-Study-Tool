import 'package:flutter/material.dart';

class KanjiGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
    );
  }
}