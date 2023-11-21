import 'package:anime_list/src/presentation/views/screen/home_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presentation/views/screen/detail_anime_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true, path: '/'),
    AutoRoute(page: DetailAnimeRoute.page, path: '/detail-anime/:id'),
  ];
}

final appRouter = AppRouter();