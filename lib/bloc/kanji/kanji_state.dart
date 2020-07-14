import 'package:unofficial_jisho_api/api.dart';

abstract class KanjiState {
  const KanjiState();
}

class KanjiSearchInitial extends KanjiState {
  KanjiSearchInitial();
}

class KanjiSearchLoading extends KanjiState {
  KanjiSearchLoading();
}

class KanjiSearchFinished extends KanjiState {
  final KanjiResult kanji;
  final bool starred;

  KanjiSearchFinished({
    this.kanji, 
    this.starred = false,
  });
}

class KanjiSearchError extends KanjiState {
  final String message;

  KanjiSearchError(this.message);
}

class ReKanjiSearch extends KanjiState {}
