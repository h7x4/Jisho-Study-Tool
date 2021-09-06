import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';

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

  const YomiChips(this.yomi, this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: _yomiWrapper(context),
    );
  }

  bool isExpandable() => yomi.length > 6;

  Widget _yomiWrapper(BuildContext context) {
    final yomiCards = this
        .yomi
        .map((yomi) => _YomiCard(
              yomi: yomi,
              colors: this.type.getColors(context),
            ))
        .toList();

    if (!this.isExpandable())
      return Wrap(
        runSpacing: 10.0,
        children: yomiCards,
      );

    return ExpansionTile(
      initiallyExpanded: false,
      title: Center(
        child: _YomiCard(
          yomi: this.type.title,
          colors: this.type.getColors(context),
        ),
      ),
      children: [
        SizedBox(
          height: 20.0,
        ),
        Wrap(
          runSpacing: 10.0,
          children: yomiCards,
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }
}

class _YomiCard extends StatelessWidget {
  final String yomi;
  final ColorSet colors;

  const _YomiCard({required this.yomi, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Text(
        this.yomi,
        style: TextStyle(
          fontSize: 20.0,
          color: colors.foreground,
        ),
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
