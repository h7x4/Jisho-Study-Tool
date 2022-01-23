import 'package:flutter/material.dart';

class DefinitionAbstract extends StatelessWidget {
  final String text;
  final Color? color;

  const DefinitionAbstract({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color),
    );
  }
}
