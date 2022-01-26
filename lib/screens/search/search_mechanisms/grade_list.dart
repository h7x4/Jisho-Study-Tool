import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../data/grades.dart';
import '../../../../models/themes/theme.dart';
import '../../../../routing/routes.dart';
import '../../../components/common/loading.dart';
import '../../../components/common/square.dart';
import '../../../settings.dart';

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
        : () => Navigator.pushNamed(
              context,
              Routes.kanjiSearch,
              arguments: text,
            );

    return Square(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color.background,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.merge(TextStyle(color: color.foreground))
              .merge(japaneseFont.textStyle),
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
                [
                  _GridItem(text: strokeCount.toString(), isNumber: true),
                  ...kanji.map((k) => _GridItem(text: k)).toList(),
                ],
              ),
            ),
          ),
        ),
        grades,
      );

  Future<Widget> get makeGrids async => SingleChildScrollView(
        child: Column(
          children: await Future.wait(
            grades.keys.map(
              (grade) async => ExpansionTile(
                title: Text(grade == 7 ? 'Junior Highschool' : 'Grade $grade'),
                maintainState: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: (await gradeWidgets)[grade]!
                          .values
                          .expand((l) => l)
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose by grade')),
      body: FutureBuilder<Widget>(
        future: makeGrids,
        initialData: const LoadingScreen(),
        builder: (context, snapshot) => snapshot.data!,
      ),
    );
  }
}
