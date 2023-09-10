// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $searchPageRoute,
      $userPageRoute,
    ];

RouteBase get $searchPageRoute => GoRouteData.$route(
      path: '/',
      factory: $SearchPageRouteExtension._fromState,
    );

extension $SearchPageRouteExtension on SearchPageRoute {
  static SearchPageRoute _fromState(GoRouterState state) => SearchPageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userPageRoute => GoRouteData.$route(
      path: '/users/:login',
      factory: $UserPageRouteExtension._fromState,
    );

extension $UserPageRouteExtension on UserPageRoute {
  static UserPageRoute _fromState(GoRouterState state) => UserPageRoute(
        login: state.pathParameters['login']!,
      );

  String get location => GoRouteData.$location(
        '/users/${Uri.encodeComponent(login)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
