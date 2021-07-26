import 'package:flutter/material.dart';

class Meaning extends StatelessWidget {
  late final List<String> meanings;
  late final List<_MeaningCard> meaningCards;
  late final bool expandable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      alignment: Alignment.centerLeft,
      child: _meaningWrapper(context),
    );
  }

  Widget _meaningWrapper(BuildContext context) {
    if (expandable) {
      return ExpansionTile(
        initiallyExpanded: false,
        title: Center(child: _MeaningCard('Meanings')),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Wrap(
            runSpacing: 10.0,
            children: meaningCards,
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      );
    } else {
      return Wrap(
        runSpacing: 10.0,
        children: meaningCards,
      );
    }
  }

  Meaning(meaning) {
    this.meanings = meaning.split(', ');
    this.meaningCards =
        meanings.map((m) => _MeaningCard(m)).toList();
    this.expandable = (this.meanings.length > 6);
  }
}

class _MeaningCard extends StatelessWidget {
  final String meaning;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: Text(
        meaning,
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

  _MeaningCard(this.meaning);
}
