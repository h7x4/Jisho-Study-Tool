import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/history/history_entry.dart';
import 'database.dart';

Future<Directory> exportDirectory() async {
  final basedir = (await getExternalStorageDirectory())!;
  // TODO: fix path
  final dir = Directory(basedir.uri.resolve('export').path);
  dir.createSync(recursive: true);
  return dir;
}

/// Returns the path to which the data was saved.
Future<String> exportData() async {
  final dir = await exportDirectory();
  final savedDir = Directory.fromUri(dir.uri.resolve('saved'));
  savedDir.createSync();

  await Future.wait([
    exportHistoryTo(dir),
    exportSavedListsTo(savedDir),
  ]);
  return dir.path;
}

Future<void> exportHistoryTo(Directory dir) async {
  final file = File(dir.uri.resolve('history.json').path);
  file.createSync();
  final query = await db().query(TableNames.historyEntryOrderedByTimestamp);
  final List<HistoryEntry> entries =
      query.map((e) => HistoryEntry.fromDBMap(e)).toList();
  final List<Map<String, Object?>> jsonEntries =
      await Future.wait(entries.map((he) async => he.toJson()));
  file.writeAsStringSync(jsonEncode(jsonEntries));
}

Future<void> exportSavedListsTo(Directory dir) async {
  // TODO:
  // final query = db().query(TableNames.savedList);
  print('TODO: implement exportSavedLists');
}
