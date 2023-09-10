import 'package:app/shared/entities/pagination.dart';

class PaginationAdapter {
  static Pagination<T> fromJson<T>(Map<String, dynamic> json, T Function(dynamic) parserFn) {
    return Pagination<T>(
      pageInfo: PageInfoAdapter.fromJson(json['pageInfo']),
      items: (json['nodes'] as List).map(parserFn).toList(),
    );
  }
}

class PageInfoAdapter {
  static PageInfo fromJson(Map<String, dynamic> json) {
    return PageInfo(
      endCursor: json['endCursor'] ?? '',
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }
}
