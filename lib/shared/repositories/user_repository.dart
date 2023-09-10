import 'dart:async';

import 'package:app/shared/entities/pagination.dart';
import 'package:app/shared/entities/user.dart';
import 'package:app/shared/services/github_service.dart';

class UserRepository {
  UserRepository(this._client);

  final GitHubService _client;

  Future<User> fetchUser(String login, int repositoryCount) async {
    final result = await _client.fetchUser(login, repositoryCount);
    if (result.hasException) {
      throw result.exception!;
    } else {
      return result.parsedData!;
    }
  }

  Future<Pagination<User>> searchUsers(String query, String? cursor) async {
    final result = await _client.searchUsers(query, cursor);
    if (result.hasException) {
      throw result.exception!;
    } else {
      return result.parsedData!;
    }
  }
}
