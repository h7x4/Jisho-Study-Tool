import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

class KanjiResultCard extends StatelessWidget {
  final KanjiResult _result;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Center(
              child: Text(_result.query),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(2, 2), // changes position of shadow
                  )
                ]),
          ),
        ),
      ],
    );
  }

  KanjiResultCard(this._result);
}
