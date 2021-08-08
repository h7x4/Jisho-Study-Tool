import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/search/search_bloc.dart';
import 'package:jisho_study_tool/view/components/search/search_result_page/search_card.dart';
import 'package:unofficial_jisho_api/api.dart';

class SearchResults extends StatelessWidget {
  final List<JishoResult> results;

  const SearchResults({
    required this.results,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: ListView(
        children: results.map((result) => SearchResultCard(result)).toList(),
      ),
      onWillPop: () async {
        BlocProvider.of<SearchBloc>(context).add(ReturnToInitialState());
        return false;
      },
    );
  }
}
