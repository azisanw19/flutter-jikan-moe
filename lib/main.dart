import 'package:anime_list/src/config/router/app_router.dart';
import 'package:anime_list/src/config/themes/app_themes.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/domain/repository/anime_repository_remote.dart';
import 'package:anime_list/src/domain/use_case/anime_search_use_case.dart';
import 'package:anime_list/src/domain/use_case/anime_season_now_use_case.dart';
import 'package:anime_list/src/locator.dart';
import 'package:anime_list/src/presentation/bloc/anime_bloc.dart';
import 'package:anime_list/src/service/firebase/jikan_moe_firebase.dart';
import 'package:anime_list/src/utils/constants/strings.dart';
import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  JikanMoeFirebase jikanMoeFirebase = locator<JikanMoeFirebase>();
  await jikanMoeFirebase.initializeApp();
  jikanMoeFirebase.recordFatalError();

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
          create: (_) => AnimeBloc(
            AnimeSearchUseCase(
              locator<NetworkManager>(),
              locator<AnimeRepositoryRemote>(),
              locator<AnimeRepositoryLocal>(),
            ),
            AnimeSeasonNowUseCase(
              locator<NetworkManager>(),
              locator<AnimeRepositoryRemote>(),
              locator<AnimeRepositoryLocal>(),
            ),
            locator<AnimeRepositoryLocal>(),
          ),
        ),
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
