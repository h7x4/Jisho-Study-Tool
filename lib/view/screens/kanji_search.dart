import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_bar.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_result_page/kanji_search_result_page.dart';
import 'package:jisho_study_tool/view/components/kanji/kanji_search_suggestion_list/kanji_search_suggestion_list.dart';
import 'package:jisho_study_tool/view/screens/loading.dart';

class KanjiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<KanjiBloc, KanjiState>(
      listener: (context, state) {
        if (state is KanjiSearchInitial) {
          FocusScope.of(context).unfocus();
        } else if (state is KanjiSearchLoading) {
          FocusScope.of(context).unfocus();
        }
      },
      child: BlocBuilder<KanjiBloc, KanjiState>(
        builder: (context, state) {
          if (state is KanjiSearchInitial) return Container();
          else if (state is KanjiSearchInput) return KanjiSuggestions(state.kanjiSuggestions);
          else if (state is KanjiSearchLoading) return LoadingScreen();
          else if (state is KanjiSearchFinished)
            return WillPopScope(
                child: KanjiResultCard(state.kanji),
                onWillPop: () async {
                  BlocProvider.of<KanjiBloc>(context)
                      .add(ReturnToInitialState());
                  return false;
                });
          throw 'No such event found';
        },
      ),
    );
  }
}

class KanjiViewBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                BlocProvider.of<KanjiBloc>(context).add(ReturnToInitialState()),
          ),
          Expanded(
            child: Container(
              child: KanjiSearchBar(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}