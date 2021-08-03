import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/models/history/search.dart';
import 'package:jisho_study_tool/view/components/history/kanji_search_item.dart';
import 'package:jisho_study_tool/view/components/history/phrase_search_item.dart';
import 'package:jisho_study_tool/view/components/history/date_divider.dart';

import 'package:jisho_study_tool/objectbox.g.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      builder: (context, state) {
        if (state is DatabaseDisconnected)
          throw DatabaseNotConnectedException();

        return StreamBuilder(
          stream: ((state as DatabaseConnected).database.box<Search>().query()
                ..order(Search_.timestamp, flags: Order.descending))
              .watch(triggerImmediately: true)
              .map((query) => query.find()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Container();
            return ListView.separated(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return Container();
                Search search = snapshot.data[index - 1];
                if (search.isKanji()) {
                  return KanjiSearchItem(
                    result: search.kanjiQuery.target!,
                    timestamp: search.timestamp,
                  );
                }
                return PhraseSearchItem(
                  search: search.wordQuery.target!,
                  timestamp: search.timestamp,
                );
              },
              separatorBuilder: (context, index) {
                Function roundToDay = (DateTime date) =>
                    DateTime(date.year, date.month, date.day);

                Search search = snapshot.data[index];
                DateTime searchDate = roundToDay(search.timestamp);

                bool newDate = true;

                if (index != 0) {
                  Search prevSearch = snapshot.data[index - 1];

                  DateTime prevSearchDate = roundToDay(prevSearch.timestamp);
                  newDate = prevSearchDate != searchDate;
                }

                if (newDate) {
                  if (searchDate == roundToDay(DateTime.now()))
                    return DateDivider(text: "Today");
                  else if (searchDate ==
                      roundToDay(
                          DateTime.now().subtract(const Duration(days: 1))))
                    return DateDivider(text: "Yesterday");
                  return DateDivider(date: searchDate);
                }

                return Divider();
              },
            );
          },
        );
      },
    );
  }
}
