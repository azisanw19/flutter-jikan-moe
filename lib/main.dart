import 'package:anime_list/src/config/router/app_router.dart';
import 'package:anime_list/src/config/themes/app_themes.dart';
import 'package:anime_list/src/locator.dart';
import 'package:anime_list/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(MyApp()/*MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => AnimeListProvider(),)],
    child: const MyApp(),
  )*/);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
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
          // darkTheme: AppTheme.dark,
          // themeMode: ThemeMode.dark,
        )
    );
  }
}