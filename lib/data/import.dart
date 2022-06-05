import 'dart:convert';
import 'dart:io';

import '../models/history/history_entry.dart';
import 'archive_format.dart';

Future<void> importData(Directory dir) async {
  await Future.wait([
    importHistoryFrom(dir.historyFile),
    importSavedListsFrom(dir.savedLists),
  ]);
}

Future<void> importHistoryFrom(File file) async {
  final String content = file.readAsStringSync();
  await HistoryEntry.insertJsonEntries(
    (jsonDecode(content) as List)
        .map((h) => h as Map<String, Object?>)
        .toList(),
  );
}

Future<void> importSavedListsFrom(Directory savedListsDir) async {
  print('TODO: Implement importSavedLists');
}
