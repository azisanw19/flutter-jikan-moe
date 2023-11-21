// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DetailAnimeRoute.name: (routeData) {
      final args = routeData.argsAs<DetailAnimeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailAnimeScreen(
          key: args.key,
          malId: args.malId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [DetailAnimeScreen]
class DetailAnimeRoute extends PageRouteInfo<DetailAnimeRouteArgs> {
  DetailAnimeRoute({
    Key? key,
    required int malId,
    List<PageRouteInfo>? children,
  }) : super(
          DetailAnimeRoute.name,
          args: DetailAnimeRouteArgs(
            key: key,
            malId: malId,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailAnimeRoute';

  static const PageInfo<DetailAnimeRouteArgs> page =
      PageInfo<DetailAnimeRouteArgs>(name);
}

class DetailAnimeRouteArgs {
  const DetailAnimeRouteArgs({
    this.key,
    required this.malId,
  });

  final Key? key;

  final int malId;

  @override
  String toString() {
    return 'DetailAnimeRouteArgs{key: $key, malId: $malId}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}
