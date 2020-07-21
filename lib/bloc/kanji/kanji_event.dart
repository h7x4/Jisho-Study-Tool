abstract class KanjiEvent {
  const KanjiEvent();
}

class GetKanjiSuggestions extends KanjiEvent {
  final String searchString;
  const GetKanjiSuggestions(this.searchString);
}

class GetKanji extends KanjiEvent {
  final String kanjiSearchString;
  const GetKanji(this.kanjiSearchString);
}

class ReturnToInitialState extends KanjiEvent {
  const ReturnToInitialState();
}