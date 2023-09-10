abstract final class GitHubQueries {
  static const String fetchUser = r'''
    query fetchUser($login: String!, $repositoryCount: Int!) {
      user(login: $login) {
        name
        login
        avatarUrl
        repositories(last: $repositoryCount) {
          nodes {
            name
            description
          }
        }
      }
    }
  ''';

  static const String searchUsers = r'''
    query searchUsers($query: String!, $cursor: String) {
      search(query: $query, type: USER, first: 20, after: $cursor) {
        pageInfo {
          endCursor
          hasNextPage
        }
        nodes {
          ... on User {
            name
            login
            avatarUrl
          }
        }
      }
    }
  ''';
}
