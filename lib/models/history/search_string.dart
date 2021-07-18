import 'package:objectbox/objectbox.dart';

import 'package:jisho_study_tool/models/history/word_result.dart';

@Entity()
class SearchString {
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  String query;

  @Backlink()
  final chosenResults = ToMany<WordResult>();

  SearchString({
    this.timestamp,
    this.query,
  });

  @override
  String toString() {
  return "[${timestamp.toIso8601String()}] \"$query\"";
  }
}