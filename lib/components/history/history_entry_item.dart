import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/history/history_entry.dart';
import '../../routing/routes.dart';
import '../../services/datetime.dart';
import '../../services/snackbar.dart';
import '../../settings.dart';
import '../common/loading.dart';
import 'kanji_box.dart';

class HistoryEntryItem extends StatelessWidget {
  final HistoryEntry entry;
  final int objectKey;
  final void Function()? onDelete;
  final void Function()? onFavourite;

  const HistoryEntryItem({
    required this.entry,
    required this.objectKey,
    this.onDelete,
    this.onFavourite,
    Key? key,
  }) : super(key: key);

  Widget get _child => (entry.isKanji)
      ? KanjiBox(kanji: entry.kanji!)
      : Text(entry.word!);

  void Function() _onTap(context) => entry.isKanji
      ? () => Navigator.pushNamed(
            context,
            Routes.kanjiSearch,
            arguments: entry.kanji,
          )
      : () => Navigator.pushNamed(
            context,
            Routes.search,
            arguments: entry.word,
          );

  MaterialPageRoute get timestamps => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Last searched')),
          body: FutureBuilder<List<DateTime>>(
            future: entry.timestamps,
            builder: (context, snapshot) {
              // TODO: provide proper error handling
              if (snapshot.hasError)
                return ErrorWidget(snapshot.error!);
              if (!snapshot.hasData) return const LoadingScreen();
              return ListView(
                children: snapshot.data!
                    .map(
                      (ts) => ListTile(
                        title: Text('${formatDate(ts)}    ${formatTime(ts)}'),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      );

  List<SlidableAction> _actions(context) => [
        SlidableAction(
          backgroundColor: Colors.blue,
          icon: Icons.access_time,
          onPressed: (_) => Navigator.push(context, timestamps),
        ),
        SlidableAction(
          backgroundColor: Colors.yellow,
          icon: Icons.star,
          onPressed: (_) {
            showSnackbar(context, 'TODO: implement favourites');
            onFavourite?.call();
          },
        ),
        SlidableAction(
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (_) async {
            await entry.delete();
            onDelete?.call();
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: _actions(context),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          onTap: _onTap(context),
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(formatTime(entry.lastTimestamp)),
              ),
              DefaultTextStyle.merge(
                style: japaneseFont.textStyle,
                child: _child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
