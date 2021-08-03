import 'package:objectbox/objectbox.dart';

@Entity()
class KanjiQuery {
  int id;

  String kanji;

  KanjiQuery({
    this.id = 0,
    required this.kanji,
  });
}
