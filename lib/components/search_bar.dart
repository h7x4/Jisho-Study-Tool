import 'dart:io';

import 'package:flutter/material.dart';

class _LanguageOption extends StatelessWidget {
  final String _language;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Center(child: Text(_language)),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  _LanguageOption(this._language);
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            controller: TextEditingController(),
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              _LanguageOption('English'),
              _LanguageOption('Japanese'),
            ],
          ),
        ],
      ),
    );
  }
}
