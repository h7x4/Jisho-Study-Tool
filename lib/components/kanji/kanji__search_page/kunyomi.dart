import 'package:flutter/material.dart';

class Kunyomi extends StatelessWidget {
  final List<String> _kunyomi;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Row(
          children: _kunyomi.map((onyomi) {
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
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10.0),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Kunyomi(this._kunyomi);
}
