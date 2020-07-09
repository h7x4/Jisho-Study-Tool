part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchFinished extends SearchState {}

class SearchError extends SearchState {}

class ReSearch extends SearchState {}