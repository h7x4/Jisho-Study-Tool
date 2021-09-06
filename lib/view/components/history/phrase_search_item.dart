import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jisho_study_tool/models/history/word_query.dart';

import './search_item.dart';

class PhraseSearchItem extends StatelessWidget {
  final WordQuery search;
  final DateTime timestamp;

  const PhraseSearchItem({
    required this.search,
    required this.timestamp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
            caption: "Delete", color: Colors.red, icon: Icons.delete)
      ],
      child: SearchItem(
        onTap: () {
          Navigator.pushNamed(context, '/search', arguments: this.search.query);
        },
        time: timestamp,
        search: Text(search.query),
      ),
    );
  }
}
