import 'dart:convert';

import 'package:http/http.dart' as http;

class RadicalsSearchKanji {
  final String kanji;
  final int strokes;
  final int grade;
  final int gradeSort;

  RadicalsSearchKanji({
    required this.kanji,
    required this.strokes,
    required this.grade,
    required this.gradeSort,
  });

  factory RadicalsSearchKanji.fromJson(Map<String, dynamic> json) =>
      RadicalsSearchKanji(
        kanji: json['kanji'],
        strokes: json['strokes'],
        grade: json['grade'],
        gradeSort: json['grade_sort'],
      );
}

class RadicalsSearchResult {
  final List<RadicalsSearchKanji> kanji;
  final List<String> validRadicals;

  RadicalsSearchResult({
    required this.kanji,
    required this.validRadicals,
  });

  factory RadicalsSearchResult.fromJson(Map<String, dynamic> json) =>
      RadicalsSearchResult(
        kanji: (json['kanji'] as List<dynamic>)
            .map((k) => RadicalsSearchKanji.fromJson(k))
            .toList(),
        validRadicals:
            (json['is_valid_radical'] as Map<String, dynamic>).keys.toList(),
      );
}

Future<RadicalsSearchResult> searchKanjiByRadicals(
  List<String> radicals,
) async {
  final response = await http
      .get(Uri.parse('https://jisho.org/radicals/${radicals.join(',')}'));
  return RadicalsSearchResult.fromJson(jsonDecode(response.body));
}
