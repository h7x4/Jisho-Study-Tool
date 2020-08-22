import 'package:flutter/material.dart';

class Onyomi extends StatelessWidget {
  final List<String> _onyomi;
  List<_OnyomiCard> _onyomiCards;
  bool _expandable;

  Onyomi(this._onyomi) {
    _onyomiCards = _onyomi.map((onyomi) => _OnyomiCard(onyomi)).toList();
    _expandable = (_onyomi.length > 6);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: _OnyomiWrapper(context),
    );
  }

  Widget _OnyomiWrapper(BuildContext context) {
    if (_expandable) {
      return ExpansionTile(
        initiallyExpanded: false,
        title: Center(child: _OnyomiCard('Onyomi')),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Wrap(
            runSpacing: 10.0,
            children: _onyomiCards,
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      );
    } else {
      return Wrap(
        runSpacing: 10.0,
        children: _onyomiCards,
      );
    }
  }
}

class _OnyomiCard extends StatelessWidget {
  final String _onyomi;
  const _OnyomiCard(this._onyomi);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Text(
        _onyomi,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
