import 'package:flutter/material.dart';
import 'package:jisho_study_tool/bloc/theme/theme_bloc.dart';
import 'package:unofficial_jisho_api/api.dart';

class OtherForms extends StatelessWidget {
  final List<JishoJapaneseWord> otherForms;

  const OtherForms(this.otherForms);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: this.otherForms.isNotEmpty
            ? [
                Text(
                  'Other Forms',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: otherForms.map((form) => _KanaBox(form)).toList(),
                ),
              ]
            : [],
      ),
    );
  }
}

class _KanaBox extends StatelessWidget {
  final JishoJapaneseWord word;

  const _KanaBox(this.word);

  @override
  Widget build(BuildContext context) {
    final hasFurigana = (word.word != null);
    final _menuColors =
        BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyLight;

    return Container(
      child: DefaultTextStyle.merge(
        child: Column(
          children: [
            // TODO: take a look at this logic
            (hasFurigana) ? Text(word.reading ?? '') : Text(''),
            (hasFurigana) ? Text(word.word!) : Text(word.reading ?? ''),
          ],
        ),
        style: TextStyle(color: _menuColors.foreground),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: _menuColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 0.5,
            offset: Offset(1, 1),
          ),
        ],
      ),
    );
  }
}
