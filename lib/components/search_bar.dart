import 'dart:io';

import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(),
      decoration: InputDecoration(
        labelText: 'Search',
        border: OutlineInputBorder()
      ),
    );
  }
}