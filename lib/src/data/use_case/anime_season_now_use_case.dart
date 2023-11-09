import 'package:anime_list/src/utils/error/use_case_exception.dart';

import '../../domain/data_transfer_object/anime_data.dart';
import '../../domain/data_transfer_object/pagination_data.dart';
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

  Future<DataState<List<AnimeData>>> getAnimeSeasonNow() async {
    bool isOnline = await _networkManager.isOnline;

    if (isOnline) {
      return _getDataFromRemote();
    } else {
      return DataStateError(UseCaseException('Unimplemented exception'));
      // return _getAnimeFromDb();
    }
  }

  Future<DataState<List<AnimeData>>> _getDataFromRemote() async {
    DataStatePagination<List<AnimeData>, PaginationData>
        dataStatePaginationAnimeDataPaginationData =
        await _getAnimeSearchRemoteRepository();

    if (dataStatePaginationAnimeDataPaginationData
        is DataStatePaginationSuccess) {
      return DataStateSuccess(dataStatePaginationAnimeDataPaginationData.data!);
    } else {
      return DataStateError(
          dataStatePaginationAnimeDataPaginationData.exception!);
    }

    /*TODO save to db*/
    /*if (dataStatePaginationAnimeDataPaginationData
    is DataStatePaginationSuccess) {
      // save to database
      await _saveAnimeToDb(dataStatePaginationAnimeDataPaginationData.data!);
      return _getAnimeFromDb();
    } else {
      return _getAnimeFromDb();
    }*/
  }

  Future<DataState<void>> _saveAnimeToDb(List<AnimeData> listAnimeData) =>
      _animeRepositoryLocal.saveAnime(listAnimeData);

  Future<DataState<List<AnimeData>>> _getAnimeFromDb() =>
      _animeRepositoryLocal.getListAnime();

  Future<DataStatePagination<List<AnimeData>, PaginationData>>
      _getAnimeSearchRemoteRepository() =>
          _animeRepositoryRemote.getAnimeSeasonNow();
}
