import 'package:flutter/material.dart';
import './badge.dart';

class JLPTBadge extends StatelessWidget {
  final String? jlptLevel;

  const JLPTBadge({
    required this.jlptLevel,
    Key? key,
  }) : super(key: key);

  String get formattedJlptLevel =>
      jlptLevel != null ? jlptLevel!.substring(5).toUpperCase() : '';

  @override
  Widget build(BuildContext context) {
    return Badge(
      color: jlptLevel != null ? Colors.blue : Colors.transparent,
      child: Text(
        formattedJlptLevel,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
