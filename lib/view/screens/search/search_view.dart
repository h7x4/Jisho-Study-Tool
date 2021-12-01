import 'package:flutter/material.dart';
import '../../components/search/search_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SearchBar(),
      ],
    );
  }
}
