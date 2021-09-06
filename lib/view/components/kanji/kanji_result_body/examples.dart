import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';
import 'package:unofficial_jisho_api/api.dart';

class Examples extends StatelessWidget {
  final List<YomiExample> onyomiExamples;
  final List<YomiExample> kunyomiExamples;

  const Examples(
    this.onyomiExamples,
    this.kunyomiExamples,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Examples:',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
        onyomiExamples
            .map((onyomiExample) => _Example(onyomiExample, _KanaType.onyomi))
            .toList(),
        kunyomiExamples
            .map(
                (kunyomiExample) => _Example(kunyomiExample, _KanaType.kunyomi))
            .toList(),
      ].expand((list) => list).toList(),
    );
  }
}

enum _KanaType { kunyomi, onyomi }

class _Example extends StatelessWidget {
  final _KanaType kanaType;
  final YomiExample yomiExample;

  const _Example(this.yomiExample, this.kanaType);

  @override
  Widget build(BuildContext context) {
    final _themeData = BlocProvider.of<ThemeBloc>(context).state.theme;
    final _kanaColors = kanaType == _KanaType.kunyomi ? _themeData.kunyomiColor : _themeData.onyomiColor;
    final _menuColors = _themeData.menuGreyNormal;

    return  Container(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
          color: _menuColors.background, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: _kanaColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Text(
                    yomiExample.reading,
                    style: TextStyle(
                      color: _kanaColors.foreground,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Text(
                    yomiExample.example,
                    style: TextStyle(
                      color: _kanaColors.foreground,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Wrap(
              children: [
                Container(
                  child: Text(
                    yomiExample.meaning,
                    style: TextStyle(
                      color: _menuColors.foreground,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
