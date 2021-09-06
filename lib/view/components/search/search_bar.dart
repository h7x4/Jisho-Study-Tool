import 'package:flutter/material.dart';
import 'package:jisho_study_tool/view/components/search/language_selector.dart';

class SearchBar extends StatelessWidget {
  const SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            onSubmitted: (text) =>
                Navigator.pushNamed(context, '/search', arguments: text),
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
          LanguageSelector()
        ],
      ),
    );
  }
}
