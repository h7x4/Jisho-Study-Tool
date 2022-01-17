import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../data/grades.dart';
import '../../../../models/themes/theme.dart';

class KanjiGradeSearch extends StatefulWidget {
  const KanjiGradeSearch({Key? key}) : super(key: key);

  @override
  _KanjiGradeSearchState createState() => _KanjiGradeSearchState();
}

class _GridItem extends StatelessWidget {
  final bool isNumber;
  final String text;
  const _GridItem({Key? key, required this.text, this.isNumber = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isNumber
        ? LightTheme.defaultMenuGreyDark
        : LightTheme.defaultMenuGreyNormal;

    final onTap = isNumber
        ? () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(text)),
            )
        : () =>
            Navigator.popAndPushNamed(context, '/kanjiSearch', arguments: text);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color.background,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: color.foreground,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

class _KanjiGradeSearchState extends State<KanjiGradeSearch> {
  Future<Map<int, Map<int, List<Widget>>>> get gradeWidgets async => compute<
          Map<int, Map<int, List<String>>>, Map<int, Map<int, List<Widget>>>>(
        (gs) => gs.map(
          (grade, sortedByStrokes) => MapEntry(
            grade,
            sortedByStrokes.map<int, List<Widget>>(
              (strokeCount, kanji) => MapEntry(
                strokeCount,
                [_GridItem(text: strokeCount.toString(), isNumber: true)] +
                    kanji.map((k) => _GridItem(text: k)).toList(),
              ),
            ),
          ),
        ),
        grades,
      );

  Future<Widget> get makeGrids async => SingleChildScrollView(
        child: Column(
          children: (await Future.wait(
            grades.keys.map(
              (grade) async => ExpansionTile(
                title: Text(grade == 7 ? 'Junior Highschool' : 'Grade $grade'),
                maintainState: true,
                children: [
                  GridView.count(
                    crossAxisCount: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.all(10),
                    children: (await gradeWidgets)[grade]!
                        .values
                        .expand((l) => l)
                        .toList(),
                  )
                ],
              ),
            ),
          ))
              .toList(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose by grade')),
      body: FutureBuilder<Widget>(
        future: makeGrids,
        initialData: const Center(child: CircularProgressIndicator()),
        builder: (context, snapshot) => snapshot.data!,
      ),
    );
  }
}
