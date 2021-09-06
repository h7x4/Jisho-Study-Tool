import 'package:flutter/material.dart';
import 'package:jisho_study_tool/view/components/search/search_results_body/search_card.dart';
import 'package:unofficial_jisho_api/api.dart';

class SearchResultsBody extends StatelessWidget {
  final List<JishoResult> results;

  const SearchResultsBody({
    required this.results,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: results.map((result) => SearchResultCard(result)).toList(),
    );
  }
}
