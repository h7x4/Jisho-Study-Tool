import 'package:objectbox/objectbox.dart';

import 'package:jisho_study_tool/models/history/search_string.dart';

@Entity()
class WordResult {
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  String word;

  final searchString = ToOne<SearchString>();

  WordResult({
    required this.timestamp,
    required this.word,
  });

  @override
  String toString() {
    return "[${timestamp.toIso8601String()}] - $word";
  }
}