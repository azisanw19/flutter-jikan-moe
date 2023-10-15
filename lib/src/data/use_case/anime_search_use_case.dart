import 'dart:async';

import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/domain/repository/anime_repository_remote.dart';
import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';
import 'package:anime_list/src/utils/resources/data_state_pagination.dart';

import '../../domain/data_transfer_object/pagination_data.dart';

class AnimeSearchUseCase {
  final NetworkManager _networkManager;
  final AnimeRepositoryRemote _animeRepositoryRemote;
  final AnimeRepositoryLocal _animeRepositoryLocal;

  const AnimeSearchUseCase(this._networkManager, this._animeRepositoryRemote,
      this._animeRepositoryLocal);

  Future<DataState<AnimeData>> getAnimeSearch() async {
    bool isOnline = await _networkManager.isOnline;

    if (isOnline) {
      DataStatePagination<List<AnimeData>, PaginationData> dataStatePaginationAnimeDataPaginationData = await _requestDataFromApi();
    } else {

    }

    throw UnimplementedError();
  }



  Future<DataStatePagination<List<AnimeData>, PaginationData>> _requestDataFromApi() => throw UnimplementedError();



  // void requestDataFromDatabase() => _animeRepositoryLocal.
}
