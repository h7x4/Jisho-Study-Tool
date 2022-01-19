import 'package:flutter/material.dart';

import '../../../bloc/theme/theme_bloc.dart';

class StrokeOrderGif extends StatelessWidget {
  final String uri;

  const StrokeOrderGif({required this.uri, Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.theme.kanjiResultColor;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(uri),
      ),
    );
  }
}
