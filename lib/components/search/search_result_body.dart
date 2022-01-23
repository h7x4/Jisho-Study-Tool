import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import 'search_results_body/search_card.dart';

class SearchResultsBody extends StatelessWidget {
  final List<JishoResult> results;

  const SearchResultsBody({
    required this.results,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final result in results) SearchResultCard(result: result)
      ],
    );
  }
}
