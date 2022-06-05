import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

export 'package:sqflite/sqlite_api.dart';

Database db() => GetIt.instance.get<Database>();

Future<Directory> _databaseDir() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  if (!appDocDir.existsSync()) appDocDir.createSync(recursive: true);
  return appDocDir;
}

Future<String> databasePath() async {
  return join((await _databaseDir()).path, 'jisho.sqlite');
}

Future<void> migrate(Database db, int oldVersion, int newVersion) async {
  final String assetManifest =
      await rootBundle.loadString('AssetManifest.json');

  final List<String> migrations =
      (jsonDecode(assetManifest) as Map<String, Object?>)
          .keys
          .where(
            (assetPath) =>
                assetPath.contains(RegExp(r'migrations\/\d{4}.*\.sql')),
          )
          .toList();

  migrations.sort();

  for (int i = oldVersion + 1; i <= newVersion; i++) {
    log(
      'Migrating database from v$i to v${i + 1} with File(${migrations[i - 1]})',
    );
    final migrationContent = await rootBundle.loadString(migrations[i - 1], cache: false);

    migrationContent
        .split(';')
        .map(
          (s) => s
              .split('\n')
              .where((l) => !l.startsWith(RegExp(r'\s*--')))
              .join('\n')
              .trim(),
        )
        .where((s) => s != '')
        .forEach(db.execute);
  }
}

Future<void> setupDatabase() async {
  databaseFactory.debugSetLogLevel(sqfliteLogLevelSql);
  final Database database = await openDatabase(
    await databasePath(),
    version: 1,
    onCreate: (db, version) => migrate(db, 0, version),
    onUpgrade: migrate,
    onOpen: (db) => Future.wait([
      db.execute('PRAGMA foreign_keys=ON')
    ]),
  );
  GetIt.instance.registerSingleton<Database>(database);
}

Future<void> resetDatabase() async {
    await db().close();
    File(await databasePath()).deleteSync();
    GetIt.instance.unregister<Database>();
    await setupDatabase();
}

class TableNames {
  /// Attributes:
  /// - id INTEGER
  static const String historyEntry = 'JST_HistoryEntry';

  /// Attributes:
  /// - entryId INTEGER
  /// - kanji CHAR(1)
  static const String historyEntryKanji = 'JST_HistoryEntryKanji';

  /// Attributes:
  /// - entryId INTEGER
  /// - timestamp INTEGER
  static const String historyEntryTimestamp = 'JST_HistoryEntryTimestamp';

  /// Attributes:
  /// - entryId INTEGER
  /// - word TEXT
  /// - language CHAR(1)?
  static const String historyEntryWord = 'JST_HistoryEntryWord';

  /// Attributes:
  /// - name TEXT
  /// - nextList TEXT
  static const String libraryList = 'JST_LibraryList';

  /// Attributes:
  /// - listName TEXT
  /// - entryText TEXT
  /// - isKanji BOOLEAN
  /// - lastModified TIMESTAMP
  /// - nextEntry TEXT
  static const String libraryListEntry = 'JST_LibraryListEntry';

  ///////////
  // VIEWS //
  ///////////

  /// Attributes:
  /// - entryId INTEGER
  /// - timestamp INTEGER
  /// - word TEXT?
  /// - kanji CHAR(1)?
  /// - language CHAR(1)?
  static const String historyEntryOrderedByTimestamp =
      'JST_HistoryEntry_orderedByTimestamp';
}
