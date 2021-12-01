import 'package:objectbox/objectbox.dart';

import './word_result.dart';

@Entity()
class WordQuery {
  int id;

  String query;

  // TODO: Link query with results that the user clicks onto.
  @Backlink()
  final chosenResults = ToMany<WordResult>();

  WordQuery({
    this.id = 0,
    required this.query,
  });
}
