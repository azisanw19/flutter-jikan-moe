import 'package:anime_list/src/utils/constants/int.dart';

import '../../domain/local/models/anime/anime_data.dart';
import '../../domain/local/models/anime/pagination_data.dart';
import '../../domain/repository/anime_repository_local.dart';
import '../../domain/repository/anime_repository_remote.dart';
import '../../utils/network/network_manager.dart';
import '../../utils/resources/data_state.dart';
import '../../utils/resources/data_state_pagination.dart';

class AnimeSeasonNowUseCase {
  final NetworkManager _networkManager;
  final AnimeRepositoryRemote _animeRepositoryRemote;
  final AnimeRepositoryLocal _animeRepositoryLocal;

  const AnimeSeasonNowUseCase(
    this._networkManager,
    this._animeRepositoryRemote,
    this._animeRepositoryLocal,
  );

  Future<DataState<List<AnimeData>>> getAnimeSeasonNow(
      int page, int limit) async {
    bool isOnline = await _networkManager.isOnline;

    if (isOnline) {
      return _getDataFromRemote(page, limit);
    } else {
      return _getAnimeFromDb(page, limit);
    }
  }

  Future<DataState<List<AnimeData>>> _getDataFromRemote(
      int page, int limit) async {
    DataStatePagination<List<AnimeData>, PaginationData>
        dataStatePaginationAnimeDataPaginationData =
        await _getAnimeSearchRemoteRepository(page, limit);

    if (dataStatePaginationAnimeDataPaginationData
        is DataStatePaginationSuccess) {
      // save to database
      if (page == firstPageAnimeSeasonNow) await _deleteAnimeThisSeason();
      await _saveAnimeToDb(dataStatePaginationAnimeDataPaginationData.data!);
      return _getAnimeFromDb(page, limit);
    } else {
      return _getAnimeFromDb(page, limit);
    }
  }

  Future<DataState<void>> _saveAnimeToDb(List<AnimeData> listAnimeData) =>
      _animeRepositoryLocal.saveAnimeThisSeason(listAnimeData);

  Future<DataState<List<AnimeData>>> _getAnimeFromDb(int page, int limit) =>
      _animeRepositoryLocal.getListAnimeSeasonNow(limit, limit * (page - 1));

  Future<DataStatePagination<List<AnimeData>, PaginationData>>
      _getAnimeSearchRemoteRepository(int page, int limit) =>
          _animeRepositoryRemote.getAnimeSeasonNow(page, limit);

  Future<DataState<void>> _deleteAnimeThisSeason() =>
      _animeRepositoryLocal.deleteAnimeThisSeason();
}
