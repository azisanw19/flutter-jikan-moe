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
    AnimeNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AnimeNavigationScreen(),
      );
    },
    AnimeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AnimePage(),
      );
    },
    DetailAnimeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailAnimeRouteArgs>(
          orElse: () => DetailAnimeRouteArgs(
              malIdAnime: pathParams.getInt('malIdAnime')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailAnimeScreen(
          key: args.key,
          malIdAnime: args.malIdAnime,
        ),
      );
    },
    EmptyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmptyScreen(),
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
    MangaRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MangaPage(),
      );
    },
  };
}

/// generated route for
/// [AnimeNavigationScreen]
class AnimeNavigationRoute extends PageRouteInfo<void> {
  const AnimeNavigationRoute({List<PageRouteInfo>? children})
      : super(
          AnimeNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimeNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AnimePage]
class AnimeRoute extends PageRouteInfo<void> {
  const AnimeRoute({List<PageRouteInfo>? children})
      : super(
          AnimeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DetailAnimeScreen]
class DetailAnimeRoute extends PageRouteInfo<DetailAnimeRouteArgs> {
  DetailAnimeRoute({
    Key? key,
    required int malIdAnime,
    List<PageRouteInfo>? children,
  }) : super(
          DetailAnimeRoute.name,
          args: DetailAnimeRouteArgs(
            key: key,
            malIdAnime: malIdAnime,
          ),
          rawPathParams: {'malIdAnime': malIdAnime},
          initialChildren: children,
        );

  static const String name = 'DetailAnimeRoute';

  static const PageInfo<DetailAnimeRouteArgs> page =
      PageInfo<DetailAnimeRouteArgs>(name);
}

class DetailAnimeRouteArgs {
  const DetailAnimeRouteArgs({
    this.key,
    required this.malIdAnime,
  });

  final Key? key;

  final int malIdAnime;

  @override
  String toString() {
    return 'DetailAnimeRouteArgs{key: $key, malIdAnime: $malIdAnime}';
  }
}

/// generated route for
/// [EmptyScreen]
class EmptyRoute extends PageRouteInfo<void> {
  const EmptyRoute({List<PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

/// generated route for
/// [MangaPage]
class MangaRoute extends PageRouteInfo<void> {
  const MangaRoute({List<PageRouteInfo>? children})
      : super(
          MangaRoute.name,
          initialChildren: children,
        );

  static const String name = 'MangaRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
