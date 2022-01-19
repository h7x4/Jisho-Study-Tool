import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../bloc/theme/theme_bloc.dart';
import '../../../../services/romaji_transliteration.dart';
import '../../../../settings.dart';

class OtherForms extends StatelessWidget {
  final List<JishoJapaneseWord> forms;

  const OtherForms({required this.forms, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: forms.isNotEmpty
          ? [
              const Text(
                'Other Forms',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: forms.map((form) => _KanaBox(form)).toList(),
              ),
            ]
          : [],
    );
  }
}

class _KanaBox extends StatelessWidget {
  final JishoJapaneseWord word;

  const _KanaBox(this.word);

  bool get hasFurigana => word.word != null;

  @override
  Widget build(BuildContext context) {
    final _menuColors =
        BlocProvider.of<ThemeBloc>(context).state.theme.menuGreyLight;
    
    final String? wordReading = word.reading == null
        ? null
        : (romajiEnabled
            ? transliterateKanaToLatin(word.reading!)
            : word.reading!);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: _menuColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 0.5,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        child: Column(
          children: [
            // See header.dart for more details about this logic
            hasFurigana ? Text(wordReading ?? '') : const Text(''),
            hasFurigana ? Text(word.word!) : Text(wordReading ?? word.word!),
          ],
        ),
        style: TextStyle(color: _menuColors.foreground),
      ),
    );
  }
}
