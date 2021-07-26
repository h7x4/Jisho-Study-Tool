import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jisho_study_tool/models/history/kanji_result.dart';

class _KanjiSearchItemHeader extends StatelessWidget {
  final KanjiResult result;

  const _KanjiSearchItemHeader(this.result, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("[KANJI] ${result.kanji} - ${result.timestamp.toIso8601String()}");
  }
}

class KanjiSearchItem extends StatelessWidget {
  final KanjiResult result;

  const KanjiSearchItem(this.result,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: ListTile(title: _KanjiSearchItemHeader(result)),
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: "Favourite",
          color: Colors.yellow,
          icon: Icons.star
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete
        )
      ],
    );
  }
}
