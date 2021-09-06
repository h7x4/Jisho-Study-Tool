import 'package:flutter/material.dart';
import './badge.dart';

class WKBadge extends StatelessWidget {
  final String wkLevel;

  const WKBadge(this.wkLevel);

  String _extractWkLevel(String wkRaw) {
    // return jlptRaw.isNotEmpty ? jlptRaw.substring(5).toUpperCase() : '';
    return wkRaw.isNotEmpty ? 'W' + wkRaw.substring(8) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      Text(
        _extractWkLevel(this.wkLevel),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      this.wkLevel.isNotEmpty ? Colors.red : Colors.transparent
    );
  }
}