import 'package:app/shared/entities/user.dart';

import 'repository_adapter.dart';

class UserAdapter {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      login: json['login'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      repositories: RepositoryAdapter.fromJsonList(
        json['repositories']?['nodes'] ?? [],
      ),
    );
  }
}
