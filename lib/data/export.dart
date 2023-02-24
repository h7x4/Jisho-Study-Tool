import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/history/history_entry.dart';
import '../models/library/library_list.dart';
import 'archive_format.dart';
import 'database.dart';

Future<Directory> exportDirectory() async =>
    (await getExternalStorageDirectory())!.exportDirectory;

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

  /// TODO: This creates a ton of sql statements. Ideally, the whole export
  /// should be done in only one query.
  /// 
  /// On second thought, is that even possible? It's a doubly nested list structure.
  final List<Map<String, Object?>> jsonEntries =
      await Future.wait(entries.map((he) async => he.toJson()));
  file.writeAsStringSync(jsonEncode(jsonEntries));
}

Future<void> exportLibraryListsTo(Directory dir) async => Future.wait(
      (await LibraryList.allLibraries).map((lib) async {
        final file = File(dir.uri.resolve('${lib.name}.json').path);
        file.createSync();
        final entries = await lib.entries;
        file.writeAsStringSync(jsonEncode(entries));
      }),
    );
