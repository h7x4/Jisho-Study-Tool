import 'package:flutter/material.dart';

class Meaning extends StatelessWidget {
  List<String> _meanings;
  List<_MeaningCard> _meaningCards;
  bool _expandable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: _MeaningWrapper(context),
    );
  }

  Widget _MeaningWrapper(BuildContext context) {
    if (_expandable) {
      return ExpansionTile(
        initiallyExpanded: false,
        title: Center(child: _MeaningCard('Meanings')),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Wrap(
            runSpacing: 10.0,
            children: _meaningCards,
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      );
    } else {
      return Wrap(
        runSpacing: 10.0,
        children: _meaningCards,
      );
    }
  }

  Meaning(_meaning) {
    this._meanings = _meaning.split(', ');
    this._meaningCards =
        _meanings.map((meaning) => _MeaningCard(meaning)).toList();
    this._expandable = (this._meanings.length > 6);
  }
}

class _MeaningCard extends StatelessWidget {
  final String _meaning;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: Text(
        _meaning,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  _MeaningCard(this._meaning);
}
