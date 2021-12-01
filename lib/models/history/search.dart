import 'package:objectbox/objectbox.dart';

import './kanji_query.dart';
import './word_query.dart';

@Entity()
class Search {
  int id;

  @Property(type: PropertyType.date)
  late final DateTime timestamp;

  final wordQuery = ToOne<WordQuery>();

  final kanjiQuery = ToOne<KanjiQuery>();

  Search({
    this.id = 0,
    required this.timestamp,
  });

  bool isKanji() {  
  //   // TODO: better error message
    if (wordQuery.target == null && kanjiQuery.target == null)
      throw Exception();
    
    return wordQuery.target == null;
  }

}
