import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unofficial_jisho_api/api.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launch(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    debugPrint('Could not open url: $url');
  }
}

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
              onPressed: () => _launch(link),
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
        onPressed: () => _launch(link),
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
  RegExp(r'^Read “.+” on DBpedia$'): _dbpedia,
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

    final Map<RegExp, int> matches = {};
    for (int i = 0; i < newLinks.length; i++)
      for (final RegExp p in _patterns.keys)
        if (p.hasMatch(newLinks[i].text)) matches[p] = i;

    final List<String> newStringLinks = newLinks.map((l) => l.url).toList();

    final List<Widget> icons = [
      ...matches.entries
          .map((m) => _patterns[m.key]!(newStringLinks[m.value]))
          .toList(),
      if (attribution.dbpedia != null) _dbpedia(attribution.dbpedia!)
    ];

    (matches.values.toList()..sort()).reversed.forEach(newLinks.removeAt);
    final List<Widget> otherLinks =
        newLinks.map((e) => Text('[${e.text} -> ${e.url}]')).toList();

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
