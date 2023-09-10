import 'package:app/ui/pages/error/error_page.dart';
import 'package:app/ui/pages/search/search_page.dart';
import 'package:app/ui/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
  errorBuilder: (context, state) => const ErrorPage(),
);

@TypedGoRoute<SearchPageRoute>(
  path: '/',
)
final class SearchPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }
}

@TypedGoRoute<UserPageRoute>(
  path: '/users/:login',
)
final class UserPageRoute extends GoRouteData {
  final String login;
  const UserPageRoute({required this.login});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserPage(login: login);
  }
}
