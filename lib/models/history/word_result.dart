import 'package:objectbox/objectbox.dart';

import 'word_query.dart';

@Entity()
class WordResult {
  int id;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  String word;

  final searchString = ToOne<WordQuery>();

  WordResult({
    this.id = 0,
    required this.timestamp,
    required this.word,
  });
}
