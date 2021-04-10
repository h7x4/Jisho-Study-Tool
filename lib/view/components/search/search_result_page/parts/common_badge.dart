import 'package:flutter/material.dart';
import 'package:jisho_study_tool/view/components/search/search_result_page/parts/badge.dart';

class CommonBadge extends StatelessWidget {
  bool isCommon;

  CommonBadge(this.isCommon) {
    this.isCommon ??= false;
  }

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