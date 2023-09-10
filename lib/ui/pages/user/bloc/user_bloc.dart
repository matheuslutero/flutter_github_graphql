import 'dart:async';

import 'package:app/shared/entities/user.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserStateLoading()) {
    on<UserEventFetch>(_onFetchUser);
  }

  final UserRepository _repository;

  FutureOr<void> _onFetchUser(UserEventFetch event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    try {
      final user = await _repository.fetchUser(event.login, 20);
      emit(UserStateLoaded(user));
    } on Exception {
      emit(UserStateFailure());
    }
  }
}
