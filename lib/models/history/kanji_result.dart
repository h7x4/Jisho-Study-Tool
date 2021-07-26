
import 'package:objectbox/objectbox.dart';

@Entity()
class KanjiResult {
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  String kanji;

  KanjiResult({
    required this.timestamp,
    required this.kanji,
  });

  @override
  String toString() {
    return "[${timestamp.toIso8601String()}] - $kanji";
  }
}