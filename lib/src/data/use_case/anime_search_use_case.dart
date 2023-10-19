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

  Future<Stream<List<AnimeData>>> getAnimeSearch() async {
    bool isOnline = await _networkManager.isOnline;

    if (isOnline) {
      return _getDataFromRemote();
    } else {
      return _getAnimeFromDb();
    }
  }

  Future<Stream<List<AnimeData>>>
      _getDataFromRemote() async {
    DataStatePagination<List<AnimeData>, PaginationData>
        dataStatePaginationAnimeDataPaginationData =
        await _getAnimeSearchRemoteRepository();

    if (dataStatePaginationAnimeDataPaginationData
        is DataStatePaginationSuccess) {
      // save to database
      await _saveAnimeToDb(dataStatePaginationAnimeDataPaginationData.data!);
      return _getAnimeFromDb();
    } else {
      return _getAnimeFromDb();
    }
  }

  Future<DataState<void>> _saveAnimeToDb(List<AnimeData> listAnimeData) => _animeRepositoryLocal.saveAnime(listAnimeData);
  Stream<List<AnimeData>> _getAnimeFromDb() => _animeRepositoryLocal.getListAnime();

  Future<DataStatePagination<List<AnimeData>, PaginationData>>
  _getAnimeSearchRemoteRepository() =>
      _animeRepositoryRemote.getAnimeSearch();
}
