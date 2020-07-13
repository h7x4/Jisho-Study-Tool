abstract class KanjiEvent {
  const KanjiEvent();
}

class GetKanji extends KanjiEvent {
  final String kanjiSearchString;

  GetKanji(this.kanjiSearchString);
}

class ReturnToInitialState extends KanjiEvent {
  ReturnToInitialState();
}