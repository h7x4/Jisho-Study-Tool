import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../bloc/theme/theme_bloc.dart';
import 'kanji_kana_box.dart';

class OtherForms extends StatelessWidget {
  final List<JishoJapaneseWord> forms;

  const OtherForms({required this.forms, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: forms.isNotEmpty
          ? [
              const Text(
                'Other Forms:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: forms
                    .map(
                      (form) => BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return KanjiKanaBox(
                            word: form,
                            colors: state.theme.menuGreyLight,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ]
          : [],
    );
  }
}
