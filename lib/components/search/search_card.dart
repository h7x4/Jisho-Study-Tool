import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

class SearchResultCard extends StatelessWidget {
  final JishoResult _result;
  const SearchResultCard(this._result);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(_result.slug),
          Text(_result.senses.toString()),
        ],
      ),
      alignment: Alignment.center,
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
    );
  }

}

