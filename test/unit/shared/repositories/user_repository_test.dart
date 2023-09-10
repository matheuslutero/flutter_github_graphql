import 'package:app/shared/entities/pagination.dart';
import 'package:app/shared/entities/user.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:app/shared/services/github_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

import '../../../resources/mocks/query_result_mock.dart';

class GitHubServiceMock extends Mock implements GitHubService {}

void main() {
  late UserRepository userRepository;
  late GitHubServiceMock gitHubService;

  setUp(() {
    gitHubService = GitHubServiceMock();
    userRepository = UserRepository(gitHubService);
  });

  group('UserRepository', () {
    test('fetchUser returns a User when successful', () async {
      const login = 'testuser';
      const repositoryCount = 10;

      const user = User(
        name: 'Test User',
        login: login,
        avatarUrl: 'https://avatars.githubusercontent.com/u/1?v=4',
        repositories: [],
      );

      when(() => gitHubService.fetchUser(login, repositoryCount)).thenAnswer(
        (_) async => QueryResultMock(parsedData: user),
      );

      final result = await userRepository.fetchUser(login, repositoryCount);

      expect(result, equals(user));
    });

    test('fetchUser throws an exception when unsuccessful', () async {
      final exception = OperationException(
        graphqlErrors: [const GraphQLError(message: 'test error')],
      );

      when(() => gitHubService.fetchUser('testuser', 10)).thenAnswer(
        (_) async => QueryResultMock(exception: exception),
      );

      expectLater(userRepository.fetchUser('testuser', 10), throwsA(exception));
    });

    test('searchUsers returns a Pagination<User> when successful', () async {
      const query = 'testuser';
      const cursor = 'testcursor';

      const pagination = Pagination<User>(
        items: [
          User(
            name: 'Test User',
            login: 'testuser',
            avatarUrl: 'https://avatars.githubusercontent.com/u/1?v=4',
            repositories: [],
          ),
        ],
        pageInfo: PageInfo(
          endCursor: cursor,
          hasNextPage: false,
        ),
      );

      when(() => gitHubService.searchUsers(query, cursor)).thenAnswer(
        (_) async => QueryResultMock(parsedData: pagination),
      );

      final result = await userRepository.searchUsers(query, cursor);

      expect(result, equals(pagination));
    });

    test('searchUsers throws an exception when unsuccessful', () async {
      final exception = OperationException(
        graphqlErrors: [const GraphQLError(message: 'test error')],
      );

      when(() => gitHubService.searchUsers('testuser', 'testcursor')).thenAnswer(
        (_) async => QueryResultMock(exception: exception),
      );
    });
  });
}
