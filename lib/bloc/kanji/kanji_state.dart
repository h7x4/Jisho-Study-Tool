import 'package:unofficial_jisho_api/api.dart';

abstract class KanjiState {
  const KanjiState();
}

class KanjiSearchInitial extends KanjiState {
  const KanjiSearchInitial();
}

class KanjiSearchInput extends KanjiState {
  final List<String> kanjiSuggestions;
  const KanjiSearchInput(this.kanjiSuggestions);
}

class KanjiSearchLoading extends KanjiState {
  const KanjiSearchLoading();
}

class KanjiSearchFinished extends KanjiState {
  final KanjiResult kanji;
  final bool starred;

  const KanjiSearchFinished({
    this.kanji, 
    this.starred = false,
  });
}

class KanjiSearchError extends KanjiState {
  final String message;

  const KanjiSearchError(this.message);
}