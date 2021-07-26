import 'package:unofficial_jisho_api/api.dart';

abstract class KanjiState {
  const KanjiState();
}

enum KanjiSearchType {
  Initial,
  Keyboard,
  Drawing,
  Radical,
  Grade
}

class KanjiSearch extends KanjiState {
  final KanjiSearchType type;
  const KanjiSearch(this.type);
}

class KanjiSearchKeyboard extends KanjiSearch {
  final List<String> kanjiSuggestions;
  const KanjiSearchKeyboard(KanjiSearchType type, this.kanjiSuggestions) : super(type);
}

class KanjiSearchLoading extends KanjiState {
  const KanjiSearchLoading();
}

class KanjiSearchFinished extends KanjiState {
  final KanjiResult kanji;
  final bool starred;

  const KanjiSearchFinished({
    required this.kanji, 
    this.starred = false,
  });
}

class KanjiSearchError extends KanjiState {
  final String message;

  const KanjiSearchError(this.message);
}