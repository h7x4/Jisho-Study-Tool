import 'package:objectbox/objectbox.dart';

@Entity()
class Search {
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  String query;

  String type;

  Search({
    this.id,
    this.timestamp,
    this.query,
    this.type,
  });

  @override
  String toString() {
  return "${timestamp.toIso8601String()} [${type.toUpperCase()}] - $query";
  }

}