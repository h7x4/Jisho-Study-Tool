import 'package:flutter/material.dart';

class Onyomi extends StatelessWidget {
  final List<String> onyomi;
  late final List<_OnyomiCard> onyomiCards;
  late final bool expandable;

  Onyomi(this.onyomi) {
    onyomiCards = onyomi.map((onyomi) => _OnyomiCard(onyomi)).toList();
    expandable = (onyomi.length > 6);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: _onyomiWrapper(context),
    );
  }

  Widget _onyomiWrapper(BuildContext context) {
    if (expandable) {
      return ExpansionTile(
        initiallyExpanded: false,
        title: Center(child: _OnyomiCard('Onyomi')),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Wrap(
            runSpacing: 10.0,
            children: onyomiCards,
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      );
    } else {
      return Wrap(
        runSpacing: 10.0,
        children: onyomiCards,
      );
    }
  }
}

class _OnyomiCard extends StatelessWidget {
  final String onyomi;
  const _OnyomiCard(this.onyomi);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Text(
        onyomi,
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
