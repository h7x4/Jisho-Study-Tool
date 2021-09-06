import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final Color color;

  const Badge(this.child, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        child: Center(
          child: this.child
        ),
      ),
      padding: EdgeInsets.all(5),
      width: 30,
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
    );  }

}