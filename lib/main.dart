import 'package:anime_list/src/config/router/app_router.dart';
import 'package:anime_list/src/config/themes/app_themes.dart';
import 'package:anime_list/src/domain/repository/anime_repository_remote.dart';
import 'package:anime_list/src/locator.dart';
import 'package:anime_list/src/presentation/home/business/home_bloc.dart';
import 'package:anime_list/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );

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
          create: (_) => HomeBloc(locator.get<AnimeRepositoryRemote>()),
        )
      ],
      child: OKToast(
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
          themeMode: ThemeMode.dark,
        ),
      ),
    );
  }
}
