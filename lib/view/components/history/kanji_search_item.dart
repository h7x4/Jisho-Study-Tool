import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import './search_item.dart';
import '../../../bloc/theme/theme_bloc.dart';
import '../../../models/history/kanji_query.dart';
import '../../../models/themes/theme.dart';

class _KanjiBox extends StatelessWidget {
  final String kanji;

  const _KanjiBox(this.kanji);

  @override
  Widget build(BuildContext context) {
    final ColorSet _menuColors =
        BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyLight;

    return IntrinsicHeight(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(5),
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
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Favourite',
            backgroundColor: Colors.yellow,
            icon: Icons.star,
            onPressed: (_) {},
          ),
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (_) {},
          ),
        ],
      ),
      child: SearchItem(
        onTap: () {
          Navigator.pushNamed(context, '/kanjiSearch', arguments: result.kanji);
        },
        time: timestamp,
        search: _KanjiBox(result.kanji),
      ),
    );
  }
}
