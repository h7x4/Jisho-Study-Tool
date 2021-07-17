import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/models/history/search.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(),
    // );
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      builder: (context, state) {
        if (state is DatabaseDisconnected)
          throw DatabaseNotConnectedException();
        return Text(
          (state as DatabaseConnected)
            .database
            .box<Search>()
            .getAll()
            .map((e) => e.toString())
            .toString()
        );
      },
    );
  }
}
