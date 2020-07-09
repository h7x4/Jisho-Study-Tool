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

class _JlptLevel extends StatelessWidget {
  final String _jlptLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        _jlptLevel,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }

  _JlptLevel(this._jlptLevel);
}

class _Grade extends StatelessWidget {
  final String _grade;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        _grade,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  _Grade(this._grade);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_JlptLevel(_result.jlptLevel), _Grade(_result.taughtIn)],
        )
      ],
    );
  }

  KanjiResultCard(this._result);
}
