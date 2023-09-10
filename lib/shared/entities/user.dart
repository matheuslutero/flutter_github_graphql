import 'package:equatable/equatable.dart';

import 'repository.dart';

class User extends Equatable {
  final String name;
  final String login;
  final String avatarUrl;
  final List<Repository> repositories;

  const User({
    required this.name,
    required this.login,
    required this.avatarUrl,
    required this.repositories,
  });

  @override
  List<Object?> get props => [name, login, avatarUrl, repositories];
}
