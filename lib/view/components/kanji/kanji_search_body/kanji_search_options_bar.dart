import 'package:flutter/material.dart';

import '../../../../bloc/theme/theme_bloc.dart';

class KanjiSearchOptionsBar extends StatelessWidget {
  const KanjiSearchOptionsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () =>
                Navigator.pushNamed(context, '/kanjiSearch/radicals'),
          ),
          const SizedBox(width: 10,),
          _IconButton(
            icon: const Icon(Icons.school),
            onPressed: () => Navigator.pushNamed(context, '/kanjiSearch/grade'),
          ),
          const SizedBox(width: 10,),
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
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      iconSize: 30,
      color: BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyDark.background,
    );
  }
}
