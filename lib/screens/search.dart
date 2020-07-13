import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SearchBar(),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String _language;
  final Color _color;

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
          color: _color
        ),
      ),
    );
  }

  _LanguageOption(this._language, this._color);
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
              _LanguageOption('Auto', Colors.white), 
              _LanguageOption('English', Colors.white),
              _LanguageOption('Japanese', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}