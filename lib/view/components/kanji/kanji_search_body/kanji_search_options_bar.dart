import 'package:flutter/material.dart';

//TODO: Make buttons have an effect

class KanjiSearchOptionsBar extends StatelessWidget {
  const KanjiSearchOptionsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IconButton(
            icon: const Text(
              '部',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/kanjiSearch/radicals'),
          ),
          _IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {},
          ),
          _IconButton(
            icon: const Icon(Icons.mode),
            onPressed: () => Navigator.pushNamed(context, '/kanjiSearch/draw'),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;

  const _IconButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}
