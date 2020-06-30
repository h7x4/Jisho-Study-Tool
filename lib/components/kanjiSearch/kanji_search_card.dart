import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

class KanjiResultCard extends StatelessWidget {

  KanjiResult _result;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Center(child:Text(_result.query)),
      color: Colors.amber,
    );
  }

  KanjiResultCard(KanjiResult result) {
    this._result = result;
  }

}