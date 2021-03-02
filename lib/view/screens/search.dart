import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/search/search_bloc.dart';
import 'package:jisho_study_tool/view/components/search/LanguageSelector.dart';
import 'package:jisho_study_tool/view/screens/loading.dart';
import 'package:jisho_study_tool/view/components/search/search_result_page/search_card.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {},
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial)
              return _InitialView();
            else if (state is SearchLoading)
              return LoadingScreen();
            else if (state is SearchFinished) {
              return WillPopScope(
                child: ListView(
                  children: state.results
                      .map((result) => SearchResultCard(result))
                      .toList(),
                ),
                onWillPop: () async {
                  BlocProvider.of<SearchBloc>(context)
                      .add(ReturnToInitialState());
                      print('Popped');
                  return false;
                },
              );
            }
            throw 'No such event found';
          },
        ));
  }
}

class _InitialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SearchBar(),
    ]);
  }
}


class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            onSubmitted: (text) => BlocProvider.of<SearchBloc>(context)
                .add(GetSearchResults(text)),
            controller: TextEditingController(),
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          LanguageSelector(["Auto", "Japanese", "English"])
        ],
      ),
    );
  }
}
