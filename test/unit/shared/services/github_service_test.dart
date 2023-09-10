import 'package:app/shared/entities/pagination.dart';
import 'package:app/shared/entities/user.dart';
import 'package:app/shared/services/github_queries.dart';
import 'package:app/shared/services/github_service.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';

import '../../../resources/fixtures/github_service_fixtures.dart';
import '../../../resources/mocks/graphql_client_mock.dart';

void main() {
  late GitHubService gitHubService;
  late GraphQLClientMock mockClient;

  setUp(() {
    mockClient = GraphQLClientMock();
    gitHubService = GitHubService(mockClient);
  });

  group('GitHubService', () {
    test('fetchUser returns a User when successful', () async {
      const login = 'testuser';
      const repositoryCount = 10;

      final data = GitHubServiceFixtures.fetchUserSuccess(login, repositoryCount);

      mockClient.queryHandler = (options, fetchPolicy, cacheRereadPolicy) {
        expect(options.document, gql(GitHubQueries.fetchUser));
        expect(options.variables, {'login': login, 'repositoryCount': repositoryCount});

        return QueryResult(
          data: data,
          options: options,
          source: QueryResultSource.network,
        );
      };

      final result = await gitHubService.fetchUser(login, repositoryCount);

      expect(result.data, equals(data));
      expect(result.exception, isNull);
      expect(result.parsedData, isA<User>());
    });

    test('fetchUser returns exception when unsuccessful', () async {
      final exception = OperationException(
        graphqlErrors: [const GraphQLError(message: 'test error')],
      );

      mockClient.queryHandler = (options, fetchPolicy, cacheRereadPolicy) {
        return QueryResult(
          exception: exception,
          options: options,
          source: QueryResultSource.network,
        );
      };

      final result = await gitHubService.fetchUser('testuser', 10);

      expect(result.data, isNull);
      expect(result.exception, equals(exception));
      expect(result.parsedData, isNull);
    });

    test('searchUsers returns a Pagination of Users when successful', () async {
      const query = 'test';
      const cursor = 'someCursor';

      final data = GitHubServiceFixtures.searchUsersSuccess(query, 10);

      mockClient.queryHandler = (options, fetchPolicy, cacheRereadPolicy) {
        expect(options.document, gql(GitHubQueries.searchUsers));
        expect(options.variables, {'query': query, 'cursor': cursor});

        return QueryResult(
          data: data,
          options: options,
          source: QueryResultSource.network,
        );
      };

      final result = await gitHubService.searchUsers(query, cursor);

      expect(result.data, equals(data));
      expect(result.exception, isNull);
      expect(result.parsedData, isA<Pagination<User>>());
    });

    test('searchUsers returns exception when unsuccessful', () async {
      final exception = OperationException(
        graphqlErrors: [const GraphQLError(message: 'test error')],
      );

      mockClient.queryHandler = (options, fetchPolicy, cacheRereadPolicy) {
        return QueryResult(
          exception: exception,
          options: options,
          source: QueryResultSource.network,
        );
      };

      final result = await gitHubService.searchUsers('test', 'someCursor');

      expect(result.data, isNull);
      expect(result.exception, equals(exception));
      expect(result.parsedData, isNull);
    });
  });
}
