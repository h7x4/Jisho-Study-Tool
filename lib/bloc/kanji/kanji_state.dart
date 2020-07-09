part of 'kanji_bloc.dart';

@immutable
abstract class KanjiState {}

class KanjiSearchInitial extends KanjiState {}

class KanjiSearchLoading extends KanjiState {}

class KanjiSearchFinished extends KanjiState {}

class KanjiSearchError extends KanjiState {}

class ReKanjiSearch extends KanjiState {}
