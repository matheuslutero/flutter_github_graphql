class Pagination<T> {
  final PageInfo pageInfo;
  final List<T> items;

  const Pagination({
    required this.pageInfo,
    required this.items,
  });
}

class PageInfo {
  final String? endCursor;
  final bool hasNextPage;

  const PageInfo({
    required this.endCursor,
    required this.hasNextPage,
  });
}
