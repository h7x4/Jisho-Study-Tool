import 'package:flutter/material.dart';

class DenshiJishoBackground extends StatelessWidget {
  final Widget child;

  const DenshiJishoBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 30,
          left: 100,
          bottom: 30,
          child: Image.asset(
            'assets/images/denshi_jisho_background_overlay.png',
          ),
        ),
        child,
      ],
    );
  }
}
