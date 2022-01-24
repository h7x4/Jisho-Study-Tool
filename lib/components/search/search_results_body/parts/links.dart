import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unofficial_jisho_api/api.dart';

import '../../../../services/open_webpage.dart';

final BoxDecoration _iconStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  border: Border.all(),
);

Widget _wiki({
  required String link,
  required bool isJapanese,
}) =>
    Container(
      margin: const EdgeInsets.only(right: 10),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: _iconStyle,
            margin: EdgeInsets.fromLTRB(0, 0, 10, isJapanese ? 12 : 10),
            child: IconButton(
              onPressed: () => open_webpage(link),
              icon: SvgPicture.asset('assets/images/wikipedia.svg'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(isJapanese ? 10 : 8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Text(
              isJapanese ? 'J' : 'E',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'serif',
              ),
            ),
          ),
        ],
      ),
    );

Widget _dbpedia(String link) => Container(
      decoration: _iconStyle,
      child: IconButton(
        onPressed: () => open_webpage(link),
        icon: Image.asset(
          'assets/images/dbpedia.png',
        ),
      ),
    );

final Map<RegExp, Widget Function(String)> _patterns = {
  RegExp(r'^Read “.+” on English Wikipedia$'): (l) =>
      _wiki(link: l, isJapanese: false),
  RegExp(r'^Read “.+” on Japanese Wikipedia$'): (l) =>
      _wiki(link: l, isJapanese: true),
  // DBpedia comes through attribution.
  // RegExp(r'^Read “.+” on DBpedia$'): _dbpedia,
};

class Links extends StatelessWidget {
  final List<JishoSenseLink> links;
  final JishoAttribution attribution;

  const Links({
    Key? key,
    required this.links,
    required this.attribution,
  }) : super(key: key);

  List<Widget> get _body {
    if (links.isEmpty) return [];

    // Copy sense.links so that it doesn't need to be modified.
    final List<JishoSenseLink> newLinks = List.from(links);
    final List<String> newStringLinks = [for (final l in newLinks) l.url];

    final Map<RegExp, int> matches = {};
    for (int i = 0; i < newLinks.length; i++)
      for (final RegExp p in _patterns.keys)
        if (p.hasMatch(newLinks[i].text)) matches[p] = i;

    final List<Widget> icons = [
      ...[
        for (final match in matches.entries)
          _patterns[match.key]!(newStringLinks[match.value])
      ],
      if (attribution.dbpedia != null) _dbpedia(attribution.dbpedia!)
    ];

    (matches.values.toList()..sort()).reversed.forEach(newLinks.removeAt);

    final List<Widget> otherLinks = [
      for (final link in newLinks) ...[
        InkWell(
          onTap: () => open_webpage(link.url),
          child: Text(
            link.text,
            style: const TextStyle(color: Colors.blue),
          ),
        )
      ]
    ];

    return [
      const Text('Links:', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: icons),
      const SizedBox(height: 5),
      if (otherLinks.isNotEmpty) ...otherLinks,
    ];
  }

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: _body);
}
