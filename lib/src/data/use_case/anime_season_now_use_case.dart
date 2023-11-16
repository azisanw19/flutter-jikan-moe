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
      return _getAnimeFromDb();
    }
  }

  Future<DataState<List<AnimeData>>> _getDataFromRemote() async {
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

  Future<DataState<void>> _saveAnimeToDb(List<AnimeData> listAnimeData) =>
      _animeRepositoryLocal.saveAnimeThisSeason(listAnimeData);

  Future<DataState<List<AnimeData>>> _getAnimeFromDb() =>
      _animeRepositoryLocal.getListAnimeSeasonNow();

  Future<DataStatePagination<List<AnimeData>, PaginationData>>
      _getAnimeSearchRemoteRepository() =>
          _animeRepositoryRemote.getAnimeSeasonNow();
}
