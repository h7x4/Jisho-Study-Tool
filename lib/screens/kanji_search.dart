import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:jisho_study_tool/components/kanji/kanji__search_page/kanji_search_page.dart';
import 'package:jisho_study_tool/components/loading.dart';

class KanjiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KanjiBloc(),
      child: _KanjiSearchPage(),
    );
  }
}

class _KanjiSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KanjiBloc, KanjiState>(
      builder: (context, state) {
        if (state is KanjiSearchInitial) return KanjiSearchBar();
        else if (state is KanjiSearchLoading) return LoadingScreen();
        else if (state is KanjiSearchFinished) return KanjiResultCard(state.kanji);
        
        throw 'No such event found';
      },
    );
  }
}

class KanjiViewBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Kanji');
  }
}

class KanjiSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        onSubmitted: (text) => BlocProvider.of<KanjiBloc>(context).add(GetKanji(text)),
        decoration: new InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search for kanji'
        ),
      ),
    );
  }
}