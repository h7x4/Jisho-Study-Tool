import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final DateTime time;
  final Widget search;
  final void Function()? onTap;

  const SearchItem({
    required this.time,
    required this.search,
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
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(getTime()),
          ),
          search,
        ],
      ),
    );
  }
}
