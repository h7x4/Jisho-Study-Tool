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
    required this.timestamp
  }); // {

  bool isKanji() {  
  //   // TODO: better error message
    if (this.wordQuery.target == null && this.kanjiQuery.target == null)
      throw Exception();
    
    return this.wordQuery.target == null;
  }

}