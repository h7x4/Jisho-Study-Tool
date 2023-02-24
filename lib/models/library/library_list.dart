import 'dart:developer';

import 'package:collection/collection.dart';

import '../../data/database.dart';
import '../../data/database_errors.dart';
import 'library_entry.dart';

class LibraryList {
  final String name;

  const LibraryList._byName(this.name);

  static const LibraryList favourites = LibraryList._byName('favourites');

  /// Get all entries within the library, in their custom order
  Future<List<LibraryEntry>> get entries async {
    const columns = ['entryText', 'isKanji', 'lastModified'];
    final query = await db().rawQuery(
      '''
        WITH RECURSIVE "RecursionTable"(${columns.map((c) => '"$c"').join(', ')}) AS (
          SELECT ${columns.map((c) => '"$c"').join(', ')}
          FROM "${TableNames.libraryListEntry}" "I"
          WHERE "I"."listName" = ? AND "I"."prevEntryText" IS NULL
      
          UNION ALL
      
          SELECT ${columns.map((c) => '"R"."$c"').join(', ')}
          FROM "${TableNames.libraryListEntry}" "R"
          JOIN "RecursionTable" ON (
            "R"."prevEntryText" = "RecursionTable"."entryText"
            AND "R"."prevEntryIsKanji" = "RecursionTable"."isKanji"
          )
          WHERE "R"."listName" = ?
        )
        SELECT * FROM "RecursionTable";
      ''',
      [name, name],
    );

    return query.map((e) => LibraryEntry.fromDBMap(e)).toList();
  }

  /// Get all existing libraries in their custom order.
  static Future<List<LibraryList>> get allLibraries async {
    final query = await db().query(TableNames.libraryListOrdered);
    return query
        .map((lib) => LibraryList._byName(lib['name']! as String))
        .toList();
  }

  /// Generates a map of all the libraries, with the value being
  /// whether or not the specified entry is within the library.
  static Future<Map<LibraryList, bool>> allListsContains({
    required String entryText,
    required bool isKanji,
  }) async {
    final query = await db().rawQuery(
      '''
      SELECT
        *, 
        EXISTS(
          SELECT * FROM "${TableNames.libraryListEntry}"
          WHERE "listName" = "name" AND "entryText" = ? AND "isKanji" = ?
        ) AS "exists"
      FROM "${TableNames.libraryListOrdered}"
      ''',
      [entryText, isKanji ? 1 : 0],
    );

    return Map.fromEntries(
      query.map(
        (lib) => MapEntry(
          LibraryList._byName(lib['name']! as String),
          lib['exists']! as int == 1,
        ),
      ),
    );
  }

  /// Whether a library contains a specific entry
  Future<bool> contains({
    required String entryText,
    required bool isKanji,
  }) async {
    final query = await db().rawQuery(
      '''
        SELECT EXISTS(
          SELECT *
          FROM "${TableNames.libraryListEntry}"
          WHERE "listName" = ? AND "entryText" = ? AND "isKanji" = ?
        ) AS "exists"
      ''',
      [name, entryText, isKanji ? 1 : 0],
    );
    return query.first['exists']! as int == 1;
  }

  /// Whether a library contains a specific word entry
  Future<bool> containsWord(String word) => contains(
        entryText: word,
        isKanji: false,
      );

  /// Whether a library contains a specific kanjientry
  Future<bool> containsKanji(String kanji) => contains(
        entryText: kanji,
        isKanji: true,
      );

  /// Whether a library exists in the database
  static Future<bool> exists(String libraryName) async {
    final query = await db().rawQuery(
      '''
        SELECT EXISTS(
          SELECT *
          FROM "${TableNames.libraryList}"
          WHERE "name" = ? 
        ) AS "exists"
      ''',
      [libraryName],
    );
    return query.first['exists']! as int == 1;
  }

  static Future<int> amountOfLibraries() async {
    final query = await db().query(
      TableNames.libraryList,
      columns: ['COUNT(*) AS count'],
    );
    return query.first['count']! as int;
  }

  /// The amount of items within this library.
  Future<int> get length async {
    final query = await db().query(
      TableNames.libraryListEntry,
      columns: ['COUNT(*) AS count'],
      where: 'listName = ?',
      whereArgs: [name],
    );
    return query.first['count']! as int;
  }

  /// Swaps two entries within a list
  /// Will throw an exception if the entry is already in the library
  Future<void> insertEntry({
    required String entryText,
    required bool isKanji,
    int? position,
    DateTime? lastModified,
  }) async {
    // TODO: set up lastModified insertion

    if (await contains(entryText: entryText, isKanji: isKanji)) {
      throw DataAlreadyExistsError(
        tableName: TableNames.libraryListEntry,
        illegalArguments: {
          'entryText': entryText,
          'isKanji': isKanji,
        },
      );
    }

    if (position != null) {
      final len = await length;
      if (0 > position || position > len) {
        throw IndexError(
          position,
          this,
          'position',
          'Data insertion position ($position) can not be between 0 and length ($len).',
          len,
        );
      } else if (position == len) {
        insertEntry(
          entryText: entryText,
          isKanji: isKanji,
          lastModified: lastModified,
        );
        return;
      } else {
        log('Adding ${isKanji ? 'kanji ' : ''}"$entryText" to library "$name" at $position');

        final b = db().batch();

        final entriess = await entries;
        final prevEntry = entriess[position - 1];
        final nextEntry = entriess[position];

        b.insert(TableNames.libraryListEntry, {
          'listName': name,
          'entryText': entryText,
          'isKanji': isKanji ? 1 : 0,
          'prevEntryText': prevEntry.word,
          'prevEntryIsKanji': prevEntry.isKanji ? 1 : 0,
        });

        b.update(
          TableNames.libraryListEntry,
          {
            'prevEntryText': entryText,
            'prevEntryIsKanji': isKanji ? 1 : 0,
          },
          where: '"listName" = ? AND "entryText" = ? AND "isKanji" = ?',
          whereArgs: [name, nextEntry.entryText, nextEntry.isKanji ? 1 : 0],
        );

        await b.commit();

        return;
      }
    }

    log('Adding ${isKanji ? 'kanji ' : ''}"$entryText" to library "$name"');

    final LibraryEntry? prevEntry = (await entries).lastOrNull;

    await db().insert(TableNames.libraryListEntry, {
      'listName': name,
      'entryText': entryText,
      'isKanji': isKanji ? 1 : 0,
      'prevEntryText': prevEntry?.word,
      'prevEntryIsKanji': (prevEntry?.isKanji ?? false) ? 1 : 0,
    });
  }

  /// Deletes an entry within a list
  /// Will throw an exception if the entry is not in the library
  Future<void> deleteEntry({
    required String entryText,
    required bool isKanji,
  }) async {
    if (!await contains(entryText: entryText, isKanji: isKanji)) {
      throw DataNotFoundError(
        tableName: TableNames.libraryListEntry,
        illegalArguments: {
          'entryText': entryText,
          'isKanji': isKanji,
        },
      );
    }

    log('Deleting ${isKanji ? 'kanji ' : ''}"$entryText" from library "$name"');

    // TODO: these queries might be combined into one
    final entryQuery = await db().query(
      TableNames.libraryListEntry,
      where: '"listName" = ? AND "entryText" = ? AND "isKanji" = ?',
      whereArgs: [name, entryText, isKanji],
    );

    final nextEntryQuery = await db().query(
      TableNames.libraryListEntry,
      where:
          '"listName" = ? AND "prevEntryText" = ? AND "prevEntryIsKanji" = ?',
      whereArgs: [name, entryText, isKanji],
    );

    // final LibraryEntry entry = LibraryEntry.fromDBMap(entryQuery.first);

    final LibraryEntry? nextEntry =
        nextEntryQuery.map((e) => LibraryEntry.fromDBMap(e)).firstOrNull;

    final b = db().batch();

    if (nextEntry != null) {
      b.update(
        TableNames.libraryListEntry,
        {
          'prevEntryText': entryQuery.first['prevEntryText'],
          'prevEntryIsKanji': entryQuery.first['prevEntryIsKanji'],
        },
        where: '"listName" = ? AND "entryText" = ? AND "isKanji" = ?',
        whereArgs: [name, nextEntry.entryText, nextEntry.isKanji],
      );
    }

    b.delete(
      TableNames.libraryListEntry,
      where: '"listName" = ? AND "entryText" = ? AND "isKanji" = ?',
      whereArgs: [name, entryText, isKanji],
    );

    b.commit();
  }

  /// Swaps two entries within a list
  /// Will throw an error if both of the entries doesn't exist
  Future<void> swapEntries({
    required String entryText1,
    required bool isKanji1,
    required String entryText2,
    required bool isKanji2,
  }) async {
    // TODO: implement function.
    throw UnimplementedError();
  }

  /// Toggle whether an entry is in the library or not.
  /// If [overrideToggleOn] is given true or false, it will specifically insert or
  /// delete the entry respectively. Else, it will figure out whether the entry
  /// is in the library already automatically.
  Future<bool> toggleEntry({
    required String entryText,
    required bool isKanji,
    bool? overrideToggleOn,
  }) async {
    overrideToggleOn ??=
        !(await contains(entryText: entryText, isKanji: isKanji));

    if (overrideToggleOn) {
      await insertEntry(entryText: entryText, isKanji: isKanji);
    } else {
      await deleteEntry(entryText: entryText, isKanji: isKanji);
    }
    return overrideToggleOn;
  }

  Future<void> deleteAllEntries() => db().delete(
        TableNames.libraryListEntry,
        where: 'listName = ?',
        whereArgs: [name],
      );

  /// Insert a new library list into the database
  static Future<LibraryList> insert(String libraryName) async {
    if (await exists(libraryName)) {
      throw DataAlreadyExistsError(
        tableName: TableNames.libraryList,
        illegalArguments: {
          'libraryName': libraryName,
        },
      );
    }

    // This is ok, because "favourites" should always exist.
    final prevList = (await allLibraries).last;
    await db().insert(TableNames.libraryList, {
      'name': libraryName,
      'prevList': prevList.name,
    });
    return LibraryList._byName(libraryName);
  }

  /// Delete this library from the database
  Future<void> delete() async {
    if (name == 'favourites') {
      throw IllegalDeletionError(
        tableName: TableNames.libraryList,
        illegalArguments: {'name': name},
      );
    }
    await db().delete(
      TableNames.libraryList,
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}
