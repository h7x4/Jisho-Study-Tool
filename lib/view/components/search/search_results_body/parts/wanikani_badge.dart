import 'package:flutter/material.dart';
import './badge.dart';

class WKBadge extends StatelessWidget {
  final String level;

  const WKBadge({
    required this.level,
    Key? key,
  }) : super(key: key);

  String _extractWkLevel(String wkRaw) {
    return wkRaw.isNotEmpty ? 'W${wkRaw.substring(8)}' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      color: level.isNotEmpty ? Colors.red : Colors.transparent,
      child: Text(
        _extractWkLevel(level),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
