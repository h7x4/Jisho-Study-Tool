import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../models/history/history_entry.dart';
import 'archive_format.dart';

Future<void> importData(Directory dir) async {
  await Future.wait([
    importHistoryFrom(dir.historyFile),
    importLibraryListsFrom(dir.libraryDir),
  ]);
}

Future<void> importHistoryFrom(File file) async {
  final String content = file.readAsStringSync();
  final List<Map<String, Object?>> json = (jsonDecode(content) as List)
      .map((h) => h as Map<String, Object?>)
      .toList();
  log('Importing ${json.length} entries from ${file.path}');
  await HistoryEntry.insertJsonEntries(json);
}

Future<void> importLibraryListsFrom(Directory libraryListsDir) async {
  print('TODO: Implement importLibraryLists');
}
