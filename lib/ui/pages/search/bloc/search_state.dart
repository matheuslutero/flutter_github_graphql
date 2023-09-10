part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, failure }

final class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.users = const <User>[],
    this.query = '',
    this.cursor,
    this.hasReachedMax = false,
  });

  final SearchStatus status;
  final List<User> users;
  final String? cursor;
  final String query;
  final bool hasReachedMax;

  SearchState copyWith({
    SearchStatus? status,
    List<User>? users,
    String? query,
    String? cursor,
    bool? hasReachedMax,
  }) {
    return SearchState(
      status: status ?? this.status,
      users: users ?? this.users,
      query: query ?? this.query,
      cursor: cursor ?? this.cursor,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, users, query, cursor, hasReachedMax];
}
