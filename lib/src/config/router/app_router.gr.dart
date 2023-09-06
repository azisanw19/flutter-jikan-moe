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
    AnimeListRoute.name: (routeData) {
      final args = routeData.argsAs<AnimeListRouteArgs>(
          orElse: () => const AnimeListRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AnimeListScreen(key: args.key),
      );
    }
  };
}

/// generated route for
/// [AnimeListScreen]
class AnimeListRoute extends PageRouteInfo<AnimeListRouteArgs> {
  AnimeListRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AnimeListRoute.name,
          args: AnimeListRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AnimeListRoute';

  static const PageInfo<AnimeListRouteArgs> page =
      PageInfo<AnimeListRouteArgs>(name);
}

class AnimeListRouteArgs {
  const AnimeListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AnimeListRouteArgs{key: $key}';
  }
}
