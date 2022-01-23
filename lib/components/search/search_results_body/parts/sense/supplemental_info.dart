import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../../settings.dart';

class SupplementalInfo extends StatelessWidget {
  final JishoWordSense sense;
  final List<String>? supplementalInfo;
  final Color? color;

  const SupplementalInfo({
    Key? key,
    required this.sense,
    this.supplementalInfo,
    this.color,
  }) : super(key: key);

  Widget _info(JishoWordSense sense) {
    final List<String> restrictions = List.from(sense.restrictions);
    if (restrictions.isNotEmpty)
      restrictions[0] = 'Only applies to ${restrictions[0]}';

    final List<String> combinedInfo = sense.tags + sense.info + restrictions;

    return Text(
      combinedInfo.join(', '),
      style: TextStyle(color: color),
    );
  }

  List<Widget> get _body {
    if (supplementalInfo != null) return [Text(supplementalInfo!.join(', '))];

    return [
      if (sense.source.isNotEmpty)
        Text('From ${sense.source[0].language} ${sense.source[0].word}'),
      if (sense.tags.isNotEmpty ||
          sense.restrictions.isNotEmpty ||
          sense.info.isNotEmpty)
        _info(sense),
    ];
  }

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
        child: Column(children: _body),
        style: TextStyle(color: color).merge(japaneseFont.textStyle),
      );
}
