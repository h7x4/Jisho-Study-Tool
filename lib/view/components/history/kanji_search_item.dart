import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jisho_study_tool/bloc/kanji/kanji_bloc.dart';
import 'package:jisho_study_tool/bloc/navigation/navigation_bloc.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';
import 'package:jisho_study_tool/models/history/kanji_query.dart';
import 'package:jisho_study_tool/models/themes/theme.dart';

import './search_item.dart';

class _KanjiBox extends StatelessWidget {
  final String kanji;

  const _KanjiBox(this.kanji);

  @override
  Widget build(BuildContext context) {
    final ColorSet _menuColors = BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyLight;

    return IntrinsicHeight(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: _menuColors.background,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                kanji,
                style: TextStyle(
                  color: _menuColors.foreground,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KanjiSearchItem extends StatelessWidget {
  final KanjiQuery result;
  final DateTime timestamp;

  const KanjiSearchItem({
    required this.result,
    required this.timestamp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: SearchItem(
        onTap: () {
          BlocProvider.of<NavigationBloc>(context).add(ChangePage(1));
          BlocProvider.of<KanjiBloc>(context).add(GetKanji(this.result.kanji));
        },
        time: timestamp,
        search: _KanjiBox(result.kanji),
      ),
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: "Favourite",
          color: Colors.yellow,
          icon: Icons.star,
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
        ),
      ],
    );
  }
}
