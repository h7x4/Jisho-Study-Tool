import 'package:flutter/material.dart';

import '../components/common/loading.dart';
import '../components/common/opaque_box.dart';
import '../components/history/date_divider.dart';
import '../components/history/kanji_box.dart';
import '../components/history/search_item.dart';
import '../models/history/search.dart';
import '../routing/routes.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  Database get _db => GetIt.instance.get<Database>();

  Stream<Map<int, Search>> get searchStream => Search.store
      .query(finder: Finder(sortOrders: [SortOrder('timestamp', false)]))
      .onSnapshots(_db)
      .map(
        (snapshot) => Map.fromEntries(
          snapshot.where((snap) => snap.value != null).map(
                (snap) => MapEntry(
                  snap.key,
                  Search.fromJson(snap.value! as Map<String, Object?>),
                ),
              ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<int, Search>>(
      stream: searchStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LoadingScreen();

        final Map<int, Search> data = snapshot.data!;
        if (data.isEmpty)
          return const Center(
            child: Text('The history is empty.\nTry searching for something!'),
          );

        return OpaqueBox(
          child: ListView.separated(
            itemCount: data.length + 1,
            itemBuilder: historyEntryWithData(data),
            separatorBuilder:
                historyEntrySeparatorWithData(data.values.toList()),
          ),
        );
      },
    );
  }

  Widget Function(BuildContext, int) historyEntryWithData(
    Map<int, Search> data,
  ) =>
      (context, index) {
        if (index == 0) return const SizedBox.shrink();

        final Search search = data.values.toList()[index - 1];
        final int objectKey = data.keys.toList()[index - 1];

        late final Widget child;
        late final void Function() onTap;

        if (search.isKanji) {
          child = KanjiBox(kanji: search.kanjiQuery!.kanji);
          onTap = () => Navigator.pushNamed(
                context,
                Routes.kanjiSearch,
                arguments: search.kanjiQuery!.kanji,
              );
        } else {
          child = Text(search.wordQuery!.query);
          onTap = () => Navigator.pushNamed(
                context,
                Routes.search,
                arguments: search.wordQuery!.query,
              );
        }

        return SearchItem(
          time: search.timestamp,
          search: child,
          objectKey: objectKey,
          onTap: onTap,
          onDelete: () => build(context),
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

        if (index == 0 ||
            dateChangedFromLastSearch(data[index - 1], searchDate)) {
          if (searchDate == today)
            return const DateDivider(text: 'Today');
          else if (searchDate == yesterday)
            return const DateDivider(text: 'Yesterday');
          else
            return DateDivider(date: searchDate);
        }

        return const Divider(height: 0);
      };
}
