import 'package:flutter/material.dart';
import 'package:unofficial_jisho_api/api.dart';

class Examples extends StatelessWidget {
  final List<YomiExample> _onyomiExamples;
  final List<YomiExample> _kunyomiExamples;

  const Examples(
    this._onyomiExamples,
    this._kunyomiExamples,
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
          _onyomiExamples
              .map((onyomiExample) => _Example(onyomiExample, _KanaType.onyomi))
              .toList(),
          _kunyomiExamples
              .map((kunyomiExample) =>
                  _Example(kunyomiExample, _KanaType.kunyomi))
              .toList(),
        ].expand((list) => list).toList());
  }
}

enum _KanaType { kunyomi, onyomi }

class _Example extends StatelessWidget {
  final _KanaType _kanaType;
  final YomiExample _yomiExample;

  const _Example(this._yomiExample, this._kanaType);

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
                color: (_kanaType == _KanaType.kunyomi)
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
                      _yomiExample.reading,
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
                      _yomiExample.example,
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
                      _yomiExample.meaning,
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
