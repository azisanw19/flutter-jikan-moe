import 'package:anime_list/src/presentation/views/anime_list_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AnimeListRoute.page, initial: true)
  ];
}

final appRouter = AppRouter();