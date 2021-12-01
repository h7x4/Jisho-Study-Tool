import 'package:objectbox/objectbox.dart';

abstract class DatabaseState {
  const DatabaseState();
}

class DatabaseConnected extends DatabaseState {
  final Store database;
  const DatabaseConnected(this.database);
}

class DatabaseDisconnected extends DatabaseState {
  const DatabaseDisconnected();
}
