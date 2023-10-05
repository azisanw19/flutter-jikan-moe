import 'package:anime_list/src/presentation/home/views/home_screen.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true)
  ];
}

final appRouter = AppRouter();