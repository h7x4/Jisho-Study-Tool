import 'word_query.dart';

class WordResult {
  final DateTime timestamp;
  final String word;
  final WordQuery searchString;

  WordResult({
    required this.timestamp,
    required this.word,
    required this.searchString,
  });
}
