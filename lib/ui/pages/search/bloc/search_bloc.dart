import 'dart:async';

import 'package:app/shared/entities/user.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._repository) : super(const SearchState()) {
    on<SearchEventFetch>(_onFetch);
    on<SearchEventClear>(_onClear);
    on<SearchEventLoadMore>(
      _onLoadMore,
      transformer: (events, mapper) => droppable<SearchEventLoadMore>().call(
        events.throttle(const Duration(milliseconds: 800)),
        mapper,
      ),
    );
  }

  final UserRepository _repository;

  Future<void> _onFetch(
    SearchEventFetch event,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (event.query.isEmpty) {
        return emit(const SearchState());
      }
      emit(state.copyWith(status: SearchStatus.loading));
      final response = await _repository.searchUsers(event.query, null);
      emit(
        state.copyWith(
          status: SearchStatus.loaded,
          users: response.items,
          cursor: response.pageInfo.endCursor,
          query: event.query,
          hasReachedMax: !response.pageInfo.hasNextPage,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  void _onClear(
    SearchEventClear event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchState());
  }

  Future<void> _onLoadMore(
    SearchEventLoadMore event,
    Emitter<SearchState> emit,
  ) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      final response = await _repository.searchUsers(state.query, state.cursor);
      emit(
        state.copyWith(
          status: SearchStatus.loaded,
          users: List.of(state.users)..addAll(response.items),
          cursor: response.pageInfo.endCursor,
          hasReachedMax: !response.pageInfo.hasNextPage,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }
}
