import 'package:flutter/material.dart';

class Grade extends StatelessWidget {
  final String _grade;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        _grade,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }

  Grade(this._grade);
}