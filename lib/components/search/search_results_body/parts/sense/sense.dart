import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../../bloc/theme/theme_bloc.dart';
import 'antonyms.dart';
import 'definition_abstract.dart';
import 'english_definitions.dart';
import 'sentences.dart';
import 'supplemental_info.dart';

class Sense extends StatelessWidget {
  final int index;
  final JishoWordSense sense;
  final PhraseScrapeMeaning? meaning;

  const Sense({
    Key? key,
    required this.index,
    required this.sense,
    this.meaning,
  }) : super(key: key);

  List<String> _removeAntonyms(List<String> supplementalInfo) {
    for (int i = 0; i < supplementalInfo.length; i++) {
      if (RegExp(r'^Antonym: .*$').hasMatch(supplementalInfo[i])) {
        supplementalInfo.removeAt(i);
        break;
      }
    }
    return supplementalInfo;
  }

  List<String>? get _supplementalWithoutAntonyms =>
  (meaning == null) ? null : 
      _removeAntonyms(List.from(meaning!.supplemental));

  bool get hasSupplementalInfo =>
      sense.info.isNotEmpty ||
      sense.source.isNotEmpty ||
      sense.tags.isNotEmpty ||
      (_supplementalWithoutAntonyms?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: state.theme.menuGreyLight.background,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${index + 1}. ${sense.partsOfSpeech.join(', ')}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                EnglishDefinitions(
                  englishDefinitions: sense.englishDefinitions,
                  colors: state.theme.menuGreyNormal,
                ),
                if (hasSupplementalInfo)
                  SupplementalInfo(
                    sense: sense,
                    supplementalInfo: _supplementalWithoutAntonyms,
                  ),
                if (meaning?.definitionAbstract != null)
                  DefinitionAbstract(
                    text: meaning!.definitionAbstract!,
                    color: state.theme.foreground,
                  ),
                if (sense.antonyms.isNotEmpty)
                  Antonyms(antonyms: sense.antonyms),
                if (meaning != null && meaning!.sentences.isNotEmpty)
                  Sentences(sentences: meaning!.sentences)
              ]
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: e,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
}
