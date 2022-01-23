import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/history/search.dart';
import '../../settings.dart';

class SearchItem extends StatelessWidget {
  final DateTime time;
  final Widget search;
  final int objectKey;
  final void Function()? onDelete;
  final void Function()? onFavourite;
  final void Function()? onTap;

  const SearchItem({
    required this.time,
    required this.search,
    required this.objectKey,
    this.onDelete,
    this.onFavourite,
    this.onTap,
    Key? key,
  }) : super(key: key);

  String getTime() {
    final hours = time.hour.toString().padLeft(2, '0');
    final mins = time.minute.toString().padLeft(2, '0');
    return '$hours:$mins';
  }

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
            onPressed: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TODO: implement favourites')),
              );
              onFavourite?.call();
            },
          ),
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (_) {
              final Database db = GetIt.instance.get<Database>();
              Search.store.record(objectKey).delete(db);
              onDelete?.call();
            },
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(getTime()),
              ),
              DefaultTextStyle.merge(
                style: japaneseFont.textStyle,
                child: search,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
