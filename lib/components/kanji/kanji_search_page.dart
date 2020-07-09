import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

class _Header extends StatelessWidget {
  final String _kanji;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          _kanji,
          style: TextStyle(fontSize: 70.0, color: Colors.white),
        ),
      ),
    );
  }

  _Header(this._kanji);
}

class KanjiResultCard extends StatelessWidget {
  final KanjiResult _result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_Header(_result.query)],
        ),
      ],
    );
  }

  KanjiResultCard(this._result);
}
