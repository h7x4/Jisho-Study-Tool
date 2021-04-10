import 'package:flutter/material.dart';
import 'package:jisho_study_tool/view/components/search/search_result_page/parts/badge.dart';

class JLPTBadge extends StatelessWidget {
  final String jlptLevel;

  const JLPTBadge(this.jlptLevel);

  String _extractJlptLevel(String jlptRaw) {
    return jlptRaw.isNotEmpty ? jlptRaw.substring(5).toUpperCase() : '';
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      Text(
        _extractJlptLevel(this.jlptLevel),
        style: TextStyle(
          color: Colors.white
        ),
      ),
      this.jlptLevel.isNotEmpty ? Colors.blue : Colors.transparent
    );
  }
}