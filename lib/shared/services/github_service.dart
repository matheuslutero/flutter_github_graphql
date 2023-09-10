import 'package:app/shared/adapters/pagination_adapter.dart';
import 'package:app/shared/adapters/user_adapter.dart';
import 'package:app/shared/entities/pagination.dart';
import 'package:app/shared/entities/user.dart';
import 'package:app/shared/services/github_queries.dart';
import 'package:graphql/client.dart';

class GitHubService {
  GitHubService(this._client);

  final GraphQLClient _client;

  Future<QueryResult<User>> fetchUser(String login, int repositoryCount) {
    return _client.query(
      QueryOptions(
        document: gql(GitHubQueries.fetchUser),
        variables: {
          'login': login,
          'repositoryCount': repositoryCount,
        },
        parserFn: (data) => UserAdapter.fromJson(data['user']),
      ),
    );
  }

  Future<QueryResult<Pagination<User>>> searchUsers(String query, String? cursor) {
    return _client.query(
      QueryOptions(
        document: gql(GitHubQueries.searchUsers),
        variables: {
          'query': query,
          'cursor': cursor,
        },
        parserFn: (data) => PaginationAdapter.fromJson<User>(
          data['search'],
          (userData) => UserAdapter.fromJson(userData),
        ),
      ),
    );
  }
}
