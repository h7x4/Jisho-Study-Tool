import 'package:flutter/material.dart';

import '../../bloc/database/database_bloc.dart';
import '../../models/history/search.dart';
import '../../objectbox.g.dart';
import '../components/history/date_divider.dart';
import '../components/history/kanji_search_item.dart';
import '../components/history/phrase_search_item.dart';
import '../components/opaque_box.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      builder: (context, state) {
        if (state is DatabaseDisconnected) {
          throw DatabaseNotConnectedException();
        }

        return StreamBuilder<List<Search>>(
          stream: getAsyncStream(state),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            final List<Search> data = snapshot.data!;
            return OpaqueBox(
              child: ListView.separated(
                itemCount: data.length + 1,
                itemBuilder: historyEntryWithData(data),
                separatorBuilder: historyEntrySeparatorWithData(data),
              ),
            );
          },
        );
      },
    );
  }

  Stream<List<Search>> getAsyncStream(DatabaseState state) =>
      ((state as DatabaseConnected).database.box<Search>().query()
            ..order(Search_.timestamp, flags: Order.descending))
          .watch(triggerImmediately: true)
          .map((query) => query.find());

  Widget Function(BuildContext, int) historyEntryWithData(List<Search> data) =>
      (context, index) {
        if (index == 0) {
          return Container();
        }

        final Search search = data[index - 1];

        if (search.isKanji()) {
          return KanjiSearchItem(
            result: search.kanjiQuery.target!,
            timestamp: search.timestamp,
          );
        } else {
          return PhraseSearchItem(
            search: search.wordQuery.target!,
            timestamp: search.timestamp,
          );
        }
      };

  DateTime roundToDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  bool dateChangedFromLastSearch(Search prevSearch, DateTime searchDate) {
    final DateTime prevSearchDate = roundToDay(prevSearch.timestamp);
    return prevSearchDate != searchDate;
  }

  DateTime get today => roundToDay(DateTime.now());
  DateTime get yesterday =>
      roundToDay(DateTime.now().subtract(const Duration(days: 1)));

  Widget Function(BuildContext, int) historyEntrySeparatorWithData(
    List<Search> data,
  ) =>
      (context, index) {
        final Search search = data[index];
        final DateTime searchDate = roundToDay(search.timestamp);

        EdgeInsets? margin;
        if (index != 0) {
          margin = const EdgeInsets.only(bottom: 10);
        }

        if (index == 0 ||
            dateChangedFromLastSearch(data[index - 1], searchDate)) {
          if (searchDate == today)
            return DateDivider(text: 'Today', margin: margin);
          else if (searchDate == yesterday)
            return DateDivider(text: 'Yesterday', margin: margin);
          else
            return DateDivider(date: searchDate, margin: margin);
        }

        return const Divider();
      };
}
