import 'package:app/shared/services/github_service.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'env.dart';

final locator = GetIt.I;

class Deps {
  static Future<void> init() async {
    await _initGraphQL();

    locator.registerSingleton<GitHubService>(
      GitHubService(locator<GraphQLClient>()),
    );
  }

  static Future<void> _initGraphQL() async {
    await initHiveForFlutter();

    final authLink = AuthLink(getToken: () => 'Bearer ${Env.token}');
    final httpLink = HttpLink(Env.httpLink);

    locator.registerSingleton<GraphQLClient>(
      GraphQLClient(
        link: authLink.concat(httpLink),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}
