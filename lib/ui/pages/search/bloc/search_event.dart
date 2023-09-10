part of 'search_bloc.dart';

sealed class SearchEvent {}

class SearchEventFetch extends SearchEvent {
  final String query;

  SearchEventFetch(this.query);
}

class SearchEventClear extends SearchEvent {}

class SearchEventLoadMore extends SearchEvent {}
