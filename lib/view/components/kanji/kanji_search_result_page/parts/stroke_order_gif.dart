import 'package:flutter/material.dart';

class StrokeOrderGif extends StatelessWidget {
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

  StrokeOrderGif(this._uri);
}