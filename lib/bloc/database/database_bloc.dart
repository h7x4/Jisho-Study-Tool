
import 'package:flutter_bloc/flutter_bloc.dart';

import './database_event.dart';
import './database_state.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

export './database_event.dart';
export './database_not_connected_exception.dart';
export './database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {

  DatabaseBloc() : super(const DatabaseDisconnected());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event)
  async* {
    if (event is ConnectedToDatabase) {
      yield DatabaseConnected(event.database);
    } else {
      yield const DatabaseDisconnected();
    }
  }

}
