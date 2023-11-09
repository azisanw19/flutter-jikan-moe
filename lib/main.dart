import 'package:anime_list/src/config/router/app_router.dart';
import 'package:anime_list/src/config/themes/app_themes.dart';
import 'package:anime_list/src/data/use_case/anime_search_use_case.dart';
import 'package:anime_list/src/data/use_case/anime_season_now_use_case.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/domain/repository/anime_repository_remote.dart';
import 'package:anime_list/src/locator.dart';
import 'package:anime_list/src/presentation/bloc/home_bloc.dart';
import 'package:anime_list/src/utils/constants/strings.dart';
import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await initializeDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(AnimeSearchUseCase(
            locator<NetworkManager>(),
            locator<AnimeRepositoryRemote>(),
            locator<AnimeRepositoryLocal>()
          ), AnimeSeasonNowUseCase(
              locator<NetworkManager>(),
              locator<AnimeRepositoryRemote>(),
              locator<AnimeRepositoryLocal>()
          )),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: appTitle,

        /**
         * Settings Route
         */
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),

        /**
         * Settings Theme
         */
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
