import 'package:flutter/material.dart';
import './badge.dart';

class CommonBadge extends StatelessWidget {
  final bool isCommon;

  const CommonBadge(this.isCommon);

  @override
  Widget build(BuildContext context) {
    return Badge(
      Text(
        "C",
        style: TextStyle(color: this.isCommon ? Colors.white : Colors.transparent)
      ),
      this.isCommon ? Colors.green : Colors.transparent
    );
  }
}