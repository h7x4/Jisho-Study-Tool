import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/history/history_entry.dart';
import 'archive_format.dart';
import 'database.dart';

Future<Directory> exportDirectory() async {
  final basedir = (await getExternalStorageDirectory())!;
  final dir = basedir.exportDirectory;
  dir.createSync(recursive: true);
  return dir;
}

/// Returns the path to which the data was saved.
Future<String> exportData() async {
  final dir = await exportDirectory();
  final libraryDir = dir.libraryDir;
  libraryDir.createSync();

  await Future.wait([
    exportHistoryTo(dir),
    exportLibraryListsTo(libraryDir),
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

Future<void> exportLibraryListsTo(Directory dir) async {
  // TODO:
  // final query = db().query(TableNames.libraryList);
  print('TODO: implement exportLibraryLists');
}
