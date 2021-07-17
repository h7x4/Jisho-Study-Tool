
import 'package:flutter_bloc/flutter_bloc.dart';

import './database_event.dart';
import './database_state.dart';

export './database_event.dart';
export './database_state.dart';
export './database_not_connected_exception.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {

  DatabaseBloc() : super(DatabaseDisconnected());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event)
  async* {
    if (event is ConnectedToDatabase) {
      yield DatabaseConnected(event.database);
    } else {
      yield DatabaseDisconnected();
    }
  }

}