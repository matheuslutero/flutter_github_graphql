abstract final class GitHubServiceFixtures {
  static Map<String, Object?> fetchUserSuccess(String login, int repositoryCount) => {
        'user': {
          'login': login,
          'name': 'Test User',
          'avatarUrl': 'https://avatars.githubusercontent.com/u/$login?v=4',
          'repositories': {
            'nodes': List.generate(
              repositoryCount,
              (index) => {
                'name': 'test-repo-$index',
                'description': 'Test repository $index',
              },
            ),
          },
        },
      };

  static Map<String, Object?> searchUsersSuccess(String query, int resultCount) => {
        "search": {
          "pageInfo": {"endCursor": "Y3Vyc29yOjIw", "hasNextPage": true},
          "nodes": List.generate(
            resultCount,
            (index) => {
              "name": "$query-$index",
              "login": "$query-$index",
              "avatarUrl": "https://avatars.githubusercontent.com/u/$index?v=4"
            },
          ),
        }
      };
}
