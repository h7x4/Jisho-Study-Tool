
import 'package:flutter/material.dart';

class Rank extends StatelessWidget {
  final int rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        '${rank.toString()} / 2500',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
    );
  }

  Rank(this.rank);
}