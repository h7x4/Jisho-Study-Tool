// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:unofficial_jisho_api/api.dart';

Future<void> cacheData(int i) async {
  final File cacheFile = File('data/jisho/grade$i.json');
  final File kanjiFile = File('data/jouyou/grade$i.txt');
  final List<String> kanji = [
    for (final k in kanjiFile.readAsStringSync().runes) String.fromCharCode(k)
  ];

  final List<KanjiResultData> data = [];

  await Future.wait([
    for (int i = 0; i < kanji.length; i++)
      Future.delayed(Duration(milliseconds: 300 * i), () async {
        print('$i: ${kanji[i]}');
        final result = await searchForKanji(kanji[i]);
        data.add(result.data!);
      })
  ]);

  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  cacheFile.writeAsStringSync(encoder.convert(data));
}

String quote(String input) => "'${input.replaceAll("'", "''")}'";

extension SQLInserts on KanjiResultData {
  int? get jlptLevelNumber =>
      jlptLevel != null ? int.parse(jlptLevel![1]) : null;

  int? get taughtInNumber => taughtIn == null
      ? null
      : taughtIn == 'junior high'
          ? 7
          : int.parse(taughtIn![6]);

  static String get kanjiResultCols =>
      '(kanji, strokeCount, meaning, radical, jlptLevel, newspaperFrequencyRank, taughtIn, isJouyou)';
  String get kanjiResultRow =>
      // ignore: prefer_interpolation_to_compose_strings
      '("$kanji", $strokeCount, "$meaning", "${radical!.symbol}", ' +
      ((jlptLevel != null) ? '$jlptLevelNumber, ' : 'NULL, ') +
      ((newspaperFrequencyRank != null)
          ? '$newspaperFrequencyRank, '
          : 'NULL, ') +
      ((taughtIn != null) ? '$taughtInNumber, ' : 'NULL, ') +
      'true'
          ')';

  static String get yomiCols => '(yomi)';
  static String get partCols => '(part)';
  List<String> get onyomiRows => onyomi.map((y) => '("$y")').toList();
  List<String> get kunyomiRows => kunyomi.map((y) => '("$y")').toList();
  List<String> get partsRows => kunyomi.map((p) => '("$p")').toList();

  static String get yomiXRefCols => '(kanji, yomi)';
  static String get partXRefCols => '(kanji, part)';
  List<String> get onyomiXRefRows =>
      onyomi.map((y) => "('$kanji', '$y')").toList();
  List<String> get kunyomiXRefRows =>
      kunyomi.map((y) => "('$kanji', '$y')").toList();
  List<String> get partsXRefRows =>
      kunyomi.map((p) => "('$kanji', '$p')").toList();

  static String get yomiExampleCols => '(example, reading, meaning)';
  List<String> get onyomiExamplesRows => onyomiExamples
      .map(
        (y) =>
            '(${quote(y.example)}, ${quote(y.reading)}, ${quote(y.meaning)})',
      )
      .toList();
  List<String> get kunyomiExamplesRows => kunyomiExamples
      .map(
        (y) =>
            '(${quote(y.example)}, ${quote(y.reading)}, ${quote(y.meaning)})',
      )
      .toList();

  static String get yomiExampleXRefCols => '(exampleID, kanji)';
  List<String> onyomiExamplesXRefRows(int exampleID) => [
        for (int i = 0; i < onyomiExamples.length; i++)
          "(${exampleID + i}, '$kanji')"
      ];
  List<String> kunyomiExamplesXRefRows(int exampleID) => [
        for (int i = 0; i < kunyomiExamples.length; i++)
          "(${exampleID + i}, '$kanji')"
      ];
}

int exampleIDXRefCounter = 1;

List<String> generateStatements(List<KanjiResultData> kanji) {
  final List<String> statements = [];

  final List<String> tableKanjiResult = [];
  final List<String> tableOnyomi = [];
  final List<String> tableKunyomi = [];
  final List<String> tablePart = [];
  final List<String> tableOnyomiExamples = [];
  final List<String> tableKunyomiExamples = [];

  final List<String> tableOnyomiXRef = [];
  final List<String> tableKunyomiXRef = [];
  final List<String> tablePartXRef = [];
  final List<String> tableOnyomiExamplesXRef = [];
  final List<String> tableKunyomiExamplesXRef = [];

  for (final k in kanji) {
    tableKanjiResult.add(k.kanjiResultRow);
    tableOnyomi.addAll(k.onyomiRows);
    tableKunyomi.addAll(k.kunyomiRows);
    tablePart.addAll(k.partsRows);
    tableOnyomiExamples.addAll(k.onyomiExamplesRows);
    tableKunyomiExamples.addAll(k.kunyomiExamplesRows);

    tableOnyomiXRef.addAll(k.onyomiXRefRows);
    tableKunyomiXRef.addAll(k.kunyomiXRefRows);
    tablePartXRef.addAll(k.partsXRefRows);
  }

  for (final k in kanji) {
    final oxr = k.onyomiExamplesXRefRows(exampleIDXRefCounter);
    exampleIDXRefCounter += oxr.length;
    tableOnyomiExamplesXRef.addAll(oxr);
  }

  for (final k in kanji) {
    final kxr = k.kunyomiExamplesXRefRows(exampleIDXRefCounter);
    exampleIDXRefCounter += kxr.length;
    tableKunyomiExamplesXRef.addAll(kxr);
  }

  void insertStatement({
    required String table,
    required List<String> values,
    orIgnore = false,
  }) =>
      statements.add(
        'INSERT${orIgnore ? ' OR IGNORE' : ''} INTO $table VALUES\n'
        '${values.join(',\n')};\n',
      );

  insertStatement(
    table: 'Kanji_Result${SQLInserts.kanjiResultCols}',
    values: tableKanjiResult,
  );

  for (final isOnyomi in [true, false]) {
    final String name = isOnyomi ? 'Onyomi' : 'Kunyomi';
    insertStatement(
      table: 'Kanji_$name${SQLInserts.yomiCols}',
      values: isOnyomi ? tableOnyomi : tableKunyomi,
      orIgnore: true,
    );

    insertStatement(
      table: 'Kanji_Result${name}_XRef${SQLInserts.yomiXRefCols}',
      values: isOnyomi ? tableOnyomiXRef : tableKunyomiXRef,
    );

    insertStatement(
      table: 'Kanji_YomiExample${SQLInserts.yomiExampleCols}',
      values: isOnyomi ? tableOnyomiExamples : tableKunyomiExamples,
      orIgnore: true,
    );

    insertStatement(
      table: 'Kanji_Result${name}Example_XRef${SQLInserts.yomiExampleXRefCols}',
      values: isOnyomi ? tableOnyomiExamplesXRef : tableKunyomiExamplesXRef,
    );
  }

  insertStatement(
    table: 'Kanji_Part${SQLInserts.partCols}',
    values: tablePart,
    orIgnore: true,
  );

  insertStatement(
    table: 'Kanji_ResultPart_XRef${SQLInserts.partXRefCols}',
    values: tablePartXRef,
  );

  return statements;
}

Future<void> main() async {
  final dataDir = Directory('data/jisho');
  dataDir.createSync();

  final List<String> statements = [];
  for (int i = 1; i <= 7; i++) {
    final File cacheFile = File('data/jisho/grade$i.json');
    if (!cacheFile.existsSync()) {
      await cacheData(i);
    }

    final String content = cacheFile.readAsStringSync();
    final List<KanjiResultData> kanji = (jsonDecode(content) as List)
        .map((e) => KanjiResultData.fromJson(e))
        .toList();

    statements.addAll(generateStatements(kanji));
  }

  File('0004_populate_jouyou_kanji.sql')
      .writeAsStringSync(statements.join('\n'));
}
