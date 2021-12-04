import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import '../../models/history/search.dart';
import '../components/history/date_divider.dart';
import '../components/history/kanji_search_item.dart';
import '../components/history/phrase_search_item.dart';
import '../components/opaque_box.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  Database get _db => GetIt.instance.get<Database>();

  Stream<List<Search>> get searchStream => Search.store
          .query(
            finder: Finder(
              sortOrders: [SortOrder('timestamp', false)],
            ),
          )
          .onSnapshots(_db)
          .map((snapshot) {
        return snapshot
            .map<Search?>(
              (snap) => (snap.value != null)
                  ? Search.fromJson(snap.value! as Map<String, Object?>)
                  : null,
            )
            .where((s) => s != null)
            .map<Search>((s) => s!)
            .toList();
      });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Search>>(
      stream: searchStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(
            child: Text('The history is empty.\nTry searching for something!'),
          );
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
  }

  Widget Function(BuildContext, int) historyEntryWithData(List<Search> data) =>
      (context, index) {
        if (index == 0) return Container();

        final Search search = data[index - 1];

        return (search.isKanji)
            ? KanjiSearchItem(
                result: search.kanjiQuery!,
                timestamp: search.timestamp,
              )
            : PhraseSearchItem(
                search: search.wordQuery!,
                timestamp: search.timestamp,
              );
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
