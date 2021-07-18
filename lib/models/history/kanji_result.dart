
import 'package:objectbox/objectbox.dart';

@Entity()
class KanjiResult {
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  String kanji;

  KanjiResult({
    this.timestamp,
    this.kanji,
  });

  @override
  String toString() {
    return "[${timestamp.toIso8601String()}] - $kanji";
  }
}