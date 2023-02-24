class LibraryEntry {
  DateTime lastModified;
  String? kanji;
  String? word;

  bool get isKanji => word == null;
  String get title => isKanji ? kanji! : word!;
  String get entryText => isKanji ? kanji! : word!;

  LibraryEntry({
    DateTime? lastModified,
    this.kanji,
    this.word,
  })  : lastModified = lastModified ?? DateTime.now(),
        assert(kanji != null || word != null, "Library entry can't be empty");

  LibraryEntry.fromWord({
    required word,
    DateTime? lastModified,
    // ignore: prefer_initializing_formals
  })  : word = word,
        lastModified = lastModified ?? DateTime.now();

  LibraryEntry.fromKanji({
    required String kanji,
    DateTime? lastModified,
    // ignore: prefer_initializing_formals
  })  : kanji = kanji,
        lastModified = lastModified ?? DateTime.now();

  Map<String, Object?> toJson() => {
        'kanji': kanji,
        'word': word,
        'lastModified': lastModified.millisecondsSinceEpoch,
      };

  factory LibraryEntry.fromJson(Map<String, Object?> json) => json['kanji'] !=
          null
      ? LibraryEntry.fromKanji(
          kanji: json['kanji']! as String,
          lastModified:
              DateTime.fromMillisecondsSinceEpoch(json['lastModified']! as int),
        )
      : LibraryEntry.fromWord(
          word: json['word']! as String,
          lastModified:
              DateTime.fromMillisecondsSinceEpoch(json['lastModified']! as int),
        );

  factory LibraryEntry.fromDBMap(Map<String, Object?> dbObject) =>
      dbObject['isKanji']! == 1
          ? LibraryEntry.fromKanji(
              kanji: dbObject['entryText']! as String,
              lastModified: DateTime.fromMillisecondsSinceEpoch(
                dbObject['lastModified']! as int,
              ),
            )
          : LibraryEntry.fromWord(
              word: dbObject['entryText']! as String,
              lastModified: DateTime.fromMillisecondsSinceEpoch(
                dbObject['lastModified']! as int,
              ),
            );
}
