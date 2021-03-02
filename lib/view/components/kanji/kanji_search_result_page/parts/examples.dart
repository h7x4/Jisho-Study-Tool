import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

class Examples extends StatelessWidget {
  final List<YomiExample> onyomiExamples;
  final List<YomiExample> kunyomiExamples;

  const Examples(
    this.onyomiExamples,
    this.kunyomiExamples,
  );

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Examples',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        children: [
          onyomiExamples
              .map((onyomiExample) => _Example(onyomiExample, _KanaType.onyomi))
              .toList(),
          kunyomiExamples
              .map((kunyomiExample) =>
                  _Example(kunyomiExample, _KanaType.kunyomi))
              .toList(),
        ].expand((list) => list).toList());
  }
}

enum _KanaType { kunyomi, onyomi }

class _Example extends StatelessWidget {
  final _KanaType kanaType;
  final YomiExample yomiExample;

  const _Example(this.yomiExample, this.kanaType);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                color: (kanaType == _KanaType.kunyomi)
                    ? Colors.lightBlue
                    : Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      yomiExample.reading,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Text(
                      yomiExample.example,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Wrap(
                children: [
                  Container(
                    child: Text(
                      yomiExample.meaning,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
