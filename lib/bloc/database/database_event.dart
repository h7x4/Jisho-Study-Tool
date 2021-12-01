import 'package:objectbox/objectbox.dart';

abstract class DatabaseEvent {
  const DatabaseEvent();
}

class ConnectedToDatabase extends DatabaseEvent {
  final Store database;
  const ConnectedToDatabase(this.database);
}

class DisconnectedFromDatabase extends DatabaseEvent {
  const DisconnectedFromDatabase();
}
