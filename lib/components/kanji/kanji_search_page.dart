import 'package:flutter/material.dart';

import 'package:unofficial_jisho_api/api.dart';

class _Header extends StatelessWidget {
  final String _kanji;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          _kanji,
          style: TextStyle(fontSize: 80.0, color: Colors.white),
        ),
      ),
    );
  }

  _Header(this._kanji);
}

class _Rank extends StatelessWidget {
  final int _rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        '${_rank.toString()} / 2500',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
    );
  }

  _Rank(this._rank);
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
        shape: BoxShape.circle,
      ),
    );
  }

  _Grade(this._grade);
}

class _Radical extends StatelessWidget {
  final Radical _radical;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        _radical.symbol,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }

  _Radical(this._radical);
}

class _StrokeOrderGif extends StatelessWidget {
  final String _uri;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.all(5.0),
      child: ClipRRect(
        child: Image.network(_uri),
        borderRadius: BorderRadius.circular(10.0),
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  _StrokeOrderGif(this._uri);
}

class KanjiResultCard extends StatelessWidget {
  final KanjiResult _result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(child: SizedBox()),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(child: _Header(_result.query)),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: _Radical(_result.radical),
                ),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StrokeOrderGif(_result.strokeOrderGifUri),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("JLPT: ", style: TextStyle(fontSize: 20.0)),
                        _JlptLevel(_result.jlptLevel ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Grade: ", style: TextStyle(fontSize: 20.0)),
                        _Grade(_result.taughtIn ?? "⨉"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Rank: ", style: TextStyle(fontSize: 20.0)),
                        _Rank(_result.newspaperFrequencyRank ?? -1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  KanjiResultCard(this._result);
}
