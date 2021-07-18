import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/models/history/kanji_result.dart';
import 'package:jisho_study_tool/models/history/search_string.dart';
import 'package:jisho_study_tool/view/components/history/kanji_search_item.dart';
import 'package:jisho_study_tool/view/components/history/search_item.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(),
    // );
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      builder: (context, state) {
        if (state is DatabaseDisconnected)
          throw DatabaseNotConnectedException();
        return ListView(
          children: (state as DatabaseConnected)
            .database
            .box<SearchString>()
            .getAll()
            .map((e) => SearchItem(e) as Widget)
            .toList()

          + (state as DatabaseConnected)
            .database
            .box<KanjiResult>()
            .getAll()
            .map((e) => KanjiSearchItem(e) as Widget)
            .toList(),
        );
      },
    );
  }
}
