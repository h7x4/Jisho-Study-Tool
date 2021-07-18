import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jisho_study_tool/models/history/search_string.dart';

class SearchItemHeader extends StatelessWidget {
  final SearchString _search;

  const SearchItemHeader(this._search, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("[SEARCH] ${_search.query} - ${_search.timestamp.toString()}"),
    );
  }
}

class SearchItem extends StatelessWidget {
  final SearchString _search;

  const SearchItem(this._search, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete
        )
      ],
      child:  ExpansionTile(
        title: SearchItemHeader(_search),
        expandedAlignment: Alignment.topCenter,
        children: [ListTile(title: Text(_search.timestamp.toIso8601String()),)],
      )
    );
  }
}
