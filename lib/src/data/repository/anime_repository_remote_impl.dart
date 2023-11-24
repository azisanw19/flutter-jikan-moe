import 'package:anime_list/src/domain/dto/anime/anime_extension.dart';
import 'package:anime_list/src/domain/dto/anime/pagination_extension.dart';
import 'package:anime_list/src/utils/resources/data_state_pagination.dart';

import '../../domain/local/models/anime/anime_data.dart';
import '../../domain/local/models/anime/pagination_data.dart';
import '../../domain/remote/models/anime_response.dart';
import '../../utils/error/repository_remote_exception.dart';
import '../data_source/remote/jikan_moe_api_service.dart';
import 'base/base_repository_remote.dart';
import '../../domain/repository/anime_repository_remote.dart';
import '../../utils/resources/data_state.dart';

class AnimeRepositoryRemoteImpl extends BaseRepositoryRemote
    implements AnimeRepositoryRemote {
  final JikanMoeApiService _animeApiService;

  AnimeRepositoryRemoteImpl(this._animeApiService);

  @override
  Future<DataStatePagination<List<AnimeData>, PaginationData>>
      getAnimeSearch() async {
    DataState<AnimeResponse> dataStatePaginationAnimeResponse =
        await getStateOf<AnimeResponse>(
      request: () => _animeApiService.getAnimeSearch(),
    );

    return _getStateForReturn(dataStatePaginationAnimeResponse);
  }

  @override
  Future<DataStatePagination<List<AnimeData>, PaginationData>>
      getAnimeSeasonNow(int page, int limit) async {
    DataState<AnimeResponse> dataStatePaginationAnimeResponse =
        await getStateOf<AnimeResponse>(
      request: () => _animeApiService.getAnimeSeasonNow(page, limit),
    );

    return _getStateForReturn(dataStatePaginationAnimeResponse);
  }

  DataStatePagination<List<AnimeData>, PaginationData> _getStateForReturn(
      DataState<AnimeResponse> dataStateAnimeResponse) {
    if (dataStateAnimeResponse is DataStateSuccess) {
      return DataStatePaginationSuccess(
          dataStateAnimeResponse.data!.dataAnimeResponses!
              .map((dataAnimeResponse) => dataAnimeResponse.toAnimeData())
              .toList(),
          dataStateAnimeResponse.data!.pagination!.toPaginationData());
    } else if (dataStateAnimeResponse is DataStateError) {
      return DataStatePaginationError(dataStateAnimeResponse.exception!);
    } else {
      return DataStatePaginationError(RepositoryRemoteException(
          'The Base Repository Remote, Data State Loading error should never occur'));
    }
  }
}
