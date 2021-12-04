import 'package:flutter/material.dart';

import '../../../../bloc/theme/theme_bloc.dart';

enum YomiType {
  onyomi,
  kunyomi,
  meaning,
}

extension on YomiType {
  String get title {
    switch (this) {
      case YomiType.onyomi:
        return 'Onyomi';
      case YomiType.kunyomi:
        return 'Kunyomi';
      case YomiType.meaning:
        return 'Meanings';
    }
  }

  ColorSet getColors(BuildContext context) {
    final theme = BlocProvider.of<ThemeBloc>(context).state.theme;

    switch (this) {
      case YomiType.onyomi:
        return theme.onyomiColor;
      case YomiType.kunyomi:
        return theme.kunyomiColor;
      case YomiType.meaning:
        return theme.menuGreyNormal;
    }
  }
}

class YomiChips extends StatelessWidget {
  final List<String> yomi;
  final YomiType type;

  const YomiChips({
    required this.yomi,
    required this.type,
    Key? key,
  }) : super(key: key);

  bool get isExpandable => yomi.length > 6;

  Widget yomiCard({
    required BuildContext context,
    required String yomi,
    required ColorSet colors,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: type.getColors(context).background,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          yomi,
          style: TextStyle(
            fontSize: 20.0,
            color: colors.foreground,
          ),
        ),
      );

  Widget yomiWrapper(BuildContext context) {
    final yomiCards = yomi
        .map(
          (y) => yomiCard(
            context: context,
            yomi: y,
            colors: type.getColors(context),
          ),
        )
        .toList();

    if (!isExpandable)
      return Wrap(
        runSpacing: 10.0,
        children: yomiCards,
      );
    else
      return ExpansionTile(
        // initiallyExpanded: false,
        title: Center(
          child: yomiCard(
            context: context,
            yomi: type.title,
            colors: type.getColors(context),
          ),
        ),
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Wrap(
            runSpacing: 10.0,
            children: yomiCards,
          ),
          const SizedBox(
            height: 25.0,
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: yomiWrapper(context),
    );
  }
}