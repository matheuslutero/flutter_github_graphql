import 'package:app/shared/entities/repository.dart';

class RepositoryAdapter {
  static Repository fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  static List<Repository> fromJsonList(List<dynamic> json) {
    return json.map((e) => fromJson(e)).toList();
  }
}
