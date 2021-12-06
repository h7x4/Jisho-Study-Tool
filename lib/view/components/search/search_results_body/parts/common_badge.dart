import 'package:flutter/material.dart';
import './badge.dart';

class CommonBadge extends StatelessWidget {
  final bool isCommon;

  const CommonBadge({
    required this.isCommon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      color: isCommon ? Colors.green : Colors.transparent,
      child: Text(
        'C',
        style: TextStyle(
          color: isCommon ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }
}
