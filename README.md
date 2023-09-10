# Flutter GitHub GraphQL

A Flutter app that uses the [GitHub GraphQL API](https://developer.github.com/v4/) to search and display user's repositories.

It uses the [graphql_flutter](https://pub.dev/packages/graphql_flutter) package to interact with the API, [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management, [go_router](https://pub.dev/packages/go_router) for routing, and [get_it](https://pub.dev/packages/get_it) for dependency injection.

## Getting Started

### Creating a GitHub personal access token
1. Create a [GitHub personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) with the `repo` scope.
2. When running the app, enter your GitHub username and the personal access token you created.

### Running the app

```bash
flutter run --dart-define=GITHUB_TOKEN=<your_personal_token>
```
