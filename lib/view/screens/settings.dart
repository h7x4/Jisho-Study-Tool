import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_study_tool/bloc/database/database_bloc.dart';
import 'package:jisho_study_tool/models/history/search.dart';
import 'package:jisho_study_tool/objectbox.g.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Cache',
          tiles: [
            SettingsTile.switchTile(
              title: 'Cache grade 1-7 kanji (N/A)',
              switchValue: false,
              onToggle: (v) {},
            ),
            SettingsTile.switchTile(
              title: 'Cache grade standard kanji (N/A)',
              switchValue: false,
              onToggle: (v) {},
            ),
            SettingsTile.switchTile(
              title: 'Cache all favourites (N/A)',
              switchValue: false,
              onToggle: (v) {},
            ),
            SettingsTile.switchTile(
              title: 'Cache all searches (N/A)',
              switchValue: false,
              onToggle: (v) {},
            ),
          ],
        ),
        SettingsSection(
          title: 'Data',
          tiles: [
            SettingsTile(
              leading: Icon(Icons.file_download),
              title: 'Export Data (N/A)',
            ),
            SettingsTile(
              leading: Icon(Icons.delete),
              title: 'Clear History (N/A)',
              onPressed: _clearHistory,
              titleTextStyle: TextStyle(color: Colors.red),
            ),
            SettingsTile(
              leading: Icon(Icons.delete),
              title: 'Clear Favourites (N/A)',
              onPressed: (c) {},
              titleTextStyle: TextStyle(color: Colors.red),
            )
          ],
        )
      ],
    );
  }
}

void _clearHistory(context) async {
  if (await confirm(context)) {
    Store db =
        (BlocProvider.of<DatabaseBloc>(context).state as DatabaseConnected)
            .database;
    // db.box<Search>().query().build().find()
    db.box<Search>().removeAll();
  }
}
