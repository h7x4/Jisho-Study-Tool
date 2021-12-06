import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget? child;
  final Color color;

  const Badge({this.child, required this.color, Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: FittedBox(
        child: Center(
          child: child,
        ),
      ),
    );  }
}
