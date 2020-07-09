import 'package:flutter/material.dart';
import 'package:jisho_study_tool/components/search_bar.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SearchBar(),
      ],
    );
  }
}