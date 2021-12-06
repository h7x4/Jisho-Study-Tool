import 'package:sembast/sembast.dart';

import './kanji_query.dart';
import './word_query.dart';

class Search {
  final DateTime timestamp;
  final WordQuery? wordQuery;
  final KanjiQuery? kanjiQuery;

  Search.fromKanjiQuery({
    required this.timestamp,
    required KanjiQuery this.kanjiQuery,
  }) : wordQuery = null;

  Search.fromWordQuery({
    required this.timestamp,
    required WordQuery this.wordQuery,
  }) : kanjiQuery = null;

  bool get isKanji => wordQuery == null;

  Map<String, Object?> toJson() => {
        'timestamp': timestamp.millisecondsSinceEpoch,
        'wordQuery': wordQuery?.toJson(),
        'kanjiQuery': kanjiQuery?.toJson(),
      };

  factory Search.fromJson(Map<String, dynamic> json) =>
      json['wordQuery'] != null
          ? Search.fromWordQuery(
              timestamp:
                  DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
              wordQuery: WordQuery.fromJson(json['wordQuery']),
            )
          : Search.fromKanjiQuery(
              timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
              kanjiQuery: KanjiQuery.fromJson(json['kanjiQuery']),
            );

  static StoreRef<int, Object?> get store => intMapStoreFactory.store('search');
}
