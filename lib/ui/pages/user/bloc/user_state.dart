part of 'user_bloc.dart';

sealed class UserState {}

class UserStateLoading extends UserState {}

class UserStateFailure extends UserState {}

class UserStateLoaded extends UserState {
  final User user;

  UserStateLoaded(this.user);
}
