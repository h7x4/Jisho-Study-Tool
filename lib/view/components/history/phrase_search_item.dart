import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import './search_item.dart';
import '../../../models/history/word_query.dart';

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
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [

        SlidableAction(
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (_) {},
        ),
        ],

      ),
      child: SearchItem(
        onTap: () => Navigator.pushNamed(
          context,
          '/search',
          arguments: search.query,
        ),
        time: timestamp,
        search: Text(search.query),
      ),
    );
  }
}
