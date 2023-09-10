abstract final class Env {
  static const String token = String.fromEnvironment('GITHUB_TOKEN');
  static const String httpLink = String.fromEnvironment(
    'GITHUB_HTTP_LINK',
    defaultValue: 'https://api.github.com/graphql',
  );
}
