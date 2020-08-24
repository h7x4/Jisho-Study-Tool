import 'package:flutter/material.dart';

class Kunyomi extends StatelessWidget {
  final List<String> _kunyomi;
  List<_KunyomiCard> _kunyomiCards;
  bool _expandable;

  Kunyomi(this._kunyomi) {
    _kunyomiCards = _kunyomi.map((kunyomi) => _KunyomiCard(kunyomi)).toList();
    _expandable = (_kunyomi.length > 6);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: _KunyomiWrapper(context),
    );
  }

  Widget _KunyomiWrapper(BuildContext context) {
    if (_expandable) {
      return ExpansionTile(
        initiallyExpanded: false,
        title: Center(child: _KunyomiCard('Kunyomi')),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Wrap(
            runSpacing: 10.0,
            children: _kunyomiCards,
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      );
    } else {
      return Wrap(
        runSpacing: 10.0,
        children: _kunyomiCards,
      );
    }
  }
}

class _KunyomiCard extends StatelessWidget {
  final String _kunyomi;
  const _KunyomiCard(this._kunyomi);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Text(
        _kunyomi,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
