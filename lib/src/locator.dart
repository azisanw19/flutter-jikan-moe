import 'package:anime_list/src/data/repository/anime_repository_remote_impl.dart';
import 'package:anime_list/src/domain/repository/anime_repository_remote.dart';
import 'package:anime_list/src/utils/network/connectivity_manager.dart';
import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/data_source/remote/anime_api_service.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<AnimeApiService>(
    AnimeApiService(locator<Dio>())
  );

  locator.registerSingleton<AnimeRepositoryRemote>(
    AnimeRepositoryRemoteImpl(locator<AnimeApiService>())
  );

  locator.registerSingleton<NetworkManager>(
      ConnectivityManager()
  );
}