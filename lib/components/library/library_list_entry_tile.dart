import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/library/library_entry.dart';
import '../../models/library/library_list.dart';
import '../../routing/routes.dart';
import '../../settings.dart';
import '../common/kanji_box.dart';

class LibraryListEntryTile extends StatelessWidget {
  final int? index;
  final LibraryList library;
  final LibraryEntry entry;
  final void Function()? onDelete;
  final void Function()? onUpdate;

  const LibraryListEntryTile({
    Key? key,
    required this.entry,
    required this.library,
    this.index,
    this.onDelete,
    this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (_) async {
              await library.deleteEntry(
                entryText: entry.entryText,
                isKanji: entry.isKanji,
              );
              onDelete?.call();
            },
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        onTap: () async {
          await Navigator.pushNamed(
            context,
            entry.isKanji ? Routes.kanjiSearch : Routes.search,
            arguments: entry.entryText,
          );
          onUpdate?.call();
        },
        title: Row(
          children: [
            if (index != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  (index! + 1).toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .merge(japaneseFont.textStyle),
                ),
              ),
            entry.isKanji
                ? KanjiBox.headline4(context: context, kanji: entry.entryText)
                : Expanded(child: Text(entry.entryText)),
          ],
        ),
      ),
    );
  }
}
