import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:jisho_study_tool/components/kanji/kanji__search_page/kanji_search_page.dart';
import 'package:jisho_study_tool/components/loading.dart';

class KanjiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KanjiBloc, KanjiState>(
      builder: (context, state) {
        if (state is KanjiSearchInitial)
          return Container();
        else if (state is KanjiSearchLoading)
          return LoadingScreen();
        else if (state is KanjiSearchFinished)
          return WillPopScope(
              child: KanjiResultCard(state.kanji),
              onWillPop: () async {
                BlocProvider.of<KanjiBloc>(context).add(ReturnToInitialState());
                return false;
              });
        throw 'No such event found';
      },
    );
  }
}

class KanjiViewBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => BlocProvider.of<KanjiBloc>(context)
                  .add(ReturnToInitialState()),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  onSubmitted: (text) =>
                      BlocProvider.of<KanjiBloc>(context).add(GetKanji(text)),
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search for kanji',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                ),
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
      ),
    );
  }
}
