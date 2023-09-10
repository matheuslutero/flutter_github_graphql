part of 'user_bloc.dart';

sealed class UserEvent {}

class UserEventFetch extends UserEvent {
  UserEventFetch(this.login);

  final String login;
}
