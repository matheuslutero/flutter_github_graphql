import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';

class GraphQLClientMock extends Fake implements GraphQLClient {
  QueryResult Function(
    QueryOptions options,
    bool? fetchPolicy,
    CacheRereadPolicy? cacheRereadPolicy,
  )? queryHandler;

  @override
  Future<QueryResult<T>> query<T>(
    QueryOptions<T> options, {
    bool? fetchPolicy,
    CacheRereadPolicy? cacheRereadPolicy,
  }) async {
    return queryHandler!(options, fetchPolicy, cacheRereadPolicy) as QueryResult<T>;
  }
}
