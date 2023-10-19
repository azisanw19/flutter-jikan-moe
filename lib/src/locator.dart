import 'package:anime_list/src/data/data_source/local/database/jikan_moe_database.dart';
import 'package:anime_list/src/data/repository/anime_repository_local_impl.dart';
import 'package:anime_list/src/data/repository/anime_repository_remote_impl.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/domain/repository/anime_repository_remote.dart';
import 'package:anime_list/src/utils/network/connectivity_manager.dart';
import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/data_source/remote/jikan_moe_api_service.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<JikanMoeApiService>(
    JikanMoeApiService(locator<Dio>())
  );

  locator.registerSingleton<AnimeRepositoryRemote>(
    AnimeRepositoryRemoteImpl(locator<JikanMoeApiService>())
  );

  locator.registerSingleton<JikanMoeDatabase>(
    await $FloorJikanMoeDatabase.databaseBuilder('jikan-moe.db').build()
  );

  locator.registerSingleton<AnimeRepositoryLocal>(
    AnimeRepositoryLocalImpl(locator<JikanMoeDatabase>().animeDao)
  );

  locator.registerSingleton<NetworkManager>(
      ConnectivityManager()
  );
}