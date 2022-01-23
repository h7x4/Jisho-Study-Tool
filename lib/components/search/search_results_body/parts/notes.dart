import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  final List<String> notes;
  const Notes({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(notes.join(', ')),
      ],
    );
  }
}
