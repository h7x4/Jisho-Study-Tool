import 'dart:math';

import 'package:get_it/get_it.dart';

import '../../data/database.dart';

export 'package:get_it/get_it.dart';

class HistoryEntry {
  int id;
  final String? kanji;
  final String? word;
  final DateTime lastTimestamp;

  /// Whether this item is a kanji search or a word search
  bool get isKanji => word == null;

  HistoryEntry.withKanji({
    required this.id,
    required this.kanji,
    required this.lastTimestamp,
  }) : word = null;

  HistoryEntry.withWord({
    required this.id,
    required this.word,
    required this.lastTimestamp,
  }) : kanji = null;

  /// Reconstruct a HistoryEntry object with data from the database
  /// This is specifically intended for the historyEntryOrderedByTimestamp
  /// view, but it can also be used with custom searches as long as it
  /// contains the following attributes:
  ///
  /// - entryId
  /// - timestamp
  /// - searchword?
  /// - kanji?
  factory HistoryEntry.fromDBMap(Map<String, Object?> dbObject) =>
      dbObject['searchword'] != null
          ? HistoryEntry.withWord(
              id: dbObject['entryId']! as int,
              word: dbObject['searchword']! as String,
              lastTimestamp: DateTime.fromMillisecondsSinceEpoch(
                dbObject['timestamp']! as int,
              ),
            )
          : HistoryEntry.withKanji(
              id: dbObject['entryId']! as int,
              kanji: dbObject['kanji']! as String,
              lastTimestamp: DateTime.fromMillisecondsSinceEpoch(
                dbObject['timestamp']! as int,
              ),
            );

  // TODO: There is a lot in common with
  //   insertKanji,
  //   insertWord,
  //   insertJsonEntry,
  //   insertJsonEntries,
  // The commonalities should be factored into a helper function

  /// Insert a kanji history entry into the database.
  /// If it already exists, only a timestamp will be added
  static Future<HistoryEntry> insertKanji({
    required String kanji,
  }) =>
      db().transaction((txn) async {
        final DateTime timestamp = DateTime.now();
        late final int id;

        final existingEntry = await txn.query(
          TableNames.historyEntryKanji,
          where: 'kanji = ?',
          whereArgs: [kanji],
        );

        if (existingEntry.isNotEmpty) {
          // Retrieve entry record id, and add a timestamp.
          id = existingEntry.first['entryId']! as int;
          await txn.insert(TableNames.historyEntryTimestamp, {
            'entryId': id,
            'timestamp': timestamp.millisecondsSinceEpoch,
          });
        } else {
          // Create new record, and add a timestamp.
          id = await txn.insert(
            TableNames.historyEntry,
            {},
            nullColumnHack: 'id',
          );
          final Batch b = txn.batch();

          b.insert(TableNames.historyEntryTimestamp, {
            'entryId': id,
            'timestamp': timestamp.millisecondsSinceEpoch,
          });
          b.insert(TableNames.historyEntryKanji, {
            'entryId': id,
            'kanji': kanji,
          });
          await b.commit();
        }

        return HistoryEntry.withKanji(
          id: id,
          kanji: kanji,
          lastTimestamp: timestamp,
        );
      });

  /// Insert a word history entry into the database.
  /// If it already exists, only a timestamp will be added
  static Future<HistoryEntry> insertWord({
    required String word,
    String? language,
  }) =>
      db().transaction((txn) async {
        final DateTime timestamp = DateTime.now();
        late final int id;

        final existingEntry = await txn.query(
          TableNames.historyEntryWord,
          where: 'searchword = ?',
          whereArgs: [word],
        );

        if (existingEntry.isNotEmpty) {
          // Retrieve entry record id, and add a timestamp.
          id = existingEntry.first['entryId']! as int;
          await txn.insert(TableNames.historyEntryTimestamp, {
            'entryId': id,
            'timestamp': timestamp.millisecondsSinceEpoch,
          });
        } else {
          id = await txn.insert(
            TableNames.historyEntry,
            {},
            nullColumnHack: 'id',
          );
          final Batch b = txn.batch();

          b.insert(TableNames.historyEntryTimestamp, {
            'entryId': id,
            'timestamp': timestamp.millisecondsSinceEpoch,
          });
          b.insert(TableNames.historyEntryWord, {
            'entryId': id,
            'searchword': word,
            'language': {
              null: null,
              'japanese': 'j',
              'english': 'e',
            }[language]
          });
          await b.commit();
        }

        return HistoryEntry.withWord(
          id: id,
          word: word,
          lastTimestamp: timestamp,
        );
      });

  /// All recorded timestamps for this specific HistoryEntry
  /// sorted in descending order.
  Future<List<DateTime>> get timestamps async => GetIt.instance
      .get<Database>()
      .query(
        TableNames.historyEntryTimestamp,
        where: 'entryId = ?',
        whereArgs: [id],
        orderBy: 'timestamp DESC',
      )
      .then(
        (timestamps) => timestamps
            .map(
              (t) => DateTime.fromMillisecondsSinceEpoch(
                t['timestamp']! as int,
              ),
            )
            .toList(),
      );

  /// Export to json for archival reasons
  /// Combined with [insertJsonEntry], this makes up functionality for exporting
  /// and importing data from the app.
  Future<Map<String, Object?>> toJson() async => {
        'word': word,
        'kanji': kanji,
        'timestamps':
            (await timestamps).map((ts) => ts.millisecondsSinceEpoch).toList()
      };

  /// Insert archived json entry into database if it doesn't exist there already.
  /// Combined with [toJson], this makes up functionality for exporting and
  /// importing data from the app.
  static Future<HistoryEntry> insertJsonEntry(
    Map<String, Object?> json,
  ) async =>
      db().transaction((txn) async {
        final b = txn.batch();
        final bool isKanji = json['word'] == null;
        final existingEntry = isKanji
            ? await txn.query(
                TableNames.historyEntryKanji,
                where: 'kanji = ?',
                whereArgs: [json['kanji']! as String],
              )
            : await txn.query(
                TableNames.historyEntryWord,
                where: 'searchword = ?',
                whereArgs: [json['word']! as String],
              );

        late final int id;
        if (existingEntry.isEmpty) {
          id = await txn.insert(
            TableNames.historyEntry,
            {},
            nullColumnHack: 'id',
          );
          if (isKanji) {
            b.insert(TableNames.historyEntryKanji, {
              'entryId': id,
              'kanji': json['kanji']! as String,
            });
          } else {
            b.insert(TableNames.historyEntryWord, {
              'entryId': id,
              'searchword': json['word']! as String,
            });
          }
        } else {
          id = existingEntry.first['entryId']! as int;
        }
        final List<int> timestamps =
            (json['timestamps']! as List).map((ts) => ts as int).toList();
        for (final timestamp in timestamps) {
          b.insert(
            TableNames.historyEntryTimestamp,
            {
              'entryId': id,
              'timestamp': timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }

        await b.commit();

        return isKanji
            ? HistoryEntry.withKanji(
                id: id,
                kanji: json['kanji']! as String,
                lastTimestamp:
                    DateTime.fromMillisecondsSinceEpoch(timestamps.reduce(max)),
              )
            : HistoryEntry.withWord(
                id: id,
                word: json['word']! as String,
                lastTimestamp:
                    DateTime.fromMillisecondsSinceEpoch(timestamps.reduce(max)),
              );
      });

  /// An efficient implementation of [insertJsonEntry] for multiple
  /// entries.
  /// 
  /// This assumes that there are no duplicates within the elements
  /// in the json.
  static Future<List<HistoryEntry>> insertJsonEntries(
    List<Map<String, Object?>> json,
  ) =>
      db().transaction((txn) async {
        final b = txn.batch();
        final List<HistoryEntry> entries = [];
        for (final jsonObject in json) {
          final bool isKanji = jsonObject['word'] == null;
          final existingEntry = isKanji
              ? await txn.query(
                  TableNames.historyEntryKanji,
                  where: 'kanji = ?',
                  whereArgs: [jsonObject['kanji']! as String],
                )
              : await txn.query(
                  TableNames.historyEntryWord,
                  where: 'searchword = ?',
                  whereArgs: [jsonObject['word']! as String],
                );

          late final int id;
          if (existingEntry.isEmpty) {
            id = await txn.insert(
              TableNames.historyEntry,
              {},
              nullColumnHack: 'id',
            );
            if (isKanji) {
              b.insert(TableNames.historyEntryKanji, {
                'entryId': id,
                'kanji': jsonObject['kanji']! as String,
              });
            } else {
              b.insert(TableNames.historyEntryWord, {
                'entryId': id,
                'searchword': jsonObject['word']! as String,
              });
            }
          } else {
            id = existingEntry.first['entryId']! as int;
          }
          final List<int> timestamps = (jsonObject['timestamps']! as List)
              .map((ts) => ts as int)
              .toList();
          for (final timestamp in timestamps) {
            b.insert(
              TableNames.historyEntryTimestamp,
              {
                'entryId': id,
                'timestamp': timestamp,
              },
              conflictAlgorithm: ConflictAlgorithm.ignore,
            );
          }

          entries.add(
            isKanji
                ? HistoryEntry.withKanji(
                    id: id,
                    kanji: jsonObject['kanji']! as String,
                    lastTimestamp: DateTime.fromMillisecondsSinceEpoch(
                      timestamps.reduce(max),
                    ),
                  )
                : HistoryEntry.withWord(
                    id: id,
                    word: jsonObject['word']! as String,
                    lastTimestamp: DateTime.fromMillisecondsSinceEpoch(
                      timestamps.reduce(max),
                    ),
                  ),
          );
        }

        await b.commit();
        return entries;
      });

  static Future<List<HistoryEntry>> get fromDB async =>
      (await db().query(TableNames.historyEntryOrderedByTimestamp))
          .map((e) => HistoryEntry.fromDBMap(e))
          .toList();

  Future<void> delete() =>
      db().delete(TableNames.historyEntry, where: 'id = ?', whereArgs: [id]);
}
