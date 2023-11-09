import 'package:anime_list/src/domain/data_transfer_object/genre_data.dart';
import 'package:anime_list/src/domain/data_transfer_object/studio_data.dart';
import 'package:anime_list/src/domain/remote/models/data_anime_response.dart';
import 'package:anime_list/src/domain/remote/models/other_item_response.dart';
import 'package:anime_list/src/domain/remote/models/pagination_response.dart';
import 'package:anime_list/src/utils/converter/type_anime_converter.dart';
import 'package:anime_list/src/utils/resources/data_state_pagination.dart';

import '../../domain/data_transfer_object/anime_data.dart';
import '../../domain/data_transfer_object/pagination_data.dart';
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
      getAnimeSeasonNow() async {
    DataState<AnimeResponse> dataStatePaginationAnimeResponse =
        await getStateOf<AnimeResponse>(
      request: () => _animeApiService.getAnimeSeasonNow(),
    );

    return _getStateForReturn(dataStatePaginationAnimeResponse);
  }

  DataStatePagination<List<AnimeData>, PaginationData> _getStateForReturn(
      DataState<AnimeResponse> dataStateAnimeResponse) {
    if (dataStateAnimeResponse is DataStateSuccess) {

      return DataStatePaginationSuccess(
          dataStateAnimeResponse.data!.dataAnimeResponses!
              .map(_dataAnimeResponseToAnimeData)
              .toList(),
          _paginationResponseToPaginationData(
              dataStateAnimeResponse.data!.pagination!));
    } else if (dataStateAnimeResponse is DataStateError) {
      return DataStatePaginationError(
          dataStateAnimeResponse.exception!);
    } else {
      return DataStatePaginationError(RepositoryRemoteException(
          'The Base Repository Remote, Data State Loading error should never occur'));
    }
  }

  // optional: (DTO) data transfer object
  AnimeData _dataAnimeResponseToAnimeData(
          DataAnimeResponse dataAnimeResponse) =>
      AnimeData(
          dataAnimeResponse.malId,
          dataAnimeResponse.url,
          dataAnimeResponse.images?.jpg?.imageUrl,
          dataAnimeResponse.trailer?.youtubeId,
          dataAnimeResponse.trailer?.images?.imageUrl,
          dataAnimeResponse.title,
          dataAnimeResponse.titleEnglish,
          dataAnimeResponse.titleJapanese,
          dataAnimeResponse.titleSynonyms,
          dataAnimeResponse.type != null
              ? TypeAnimeConverter().encode(dataAnimeResponse.type!)
              : null,
          dataAnimeResponse.source,
          dataAnimeResponse.episodes,
          dataAnimeResponse.status,
          dataAnimeResponse.airing,
          '${dataAnimeResponse.aired?.prop?.from?.day}-${dataAnimeResponse.aired?.prop?.from?.month}-${dataAnimeResponse.aired?.prop?.from?.year}',
          '${dataAnimeResponse.aired?.prop?.to?.day}-${dataAnimeResponse.aired?.prop?.to?.month}-${dataAnimeResponse.aired?.prop?.to?.year}',
          dataAnimeResponse.duration,
          dataAnimeResponse.rating,
          dataAnimeResponse.score,
          dataAnimeResponse.scoredBy,
          dataAnimeResponse.rank,
          dataAnimeResponse.popularity,
          dataAnimeResponse.favorites,
          dataAnimeResponse.synopsis,
          dataAnimeResponse.background,
          dataAnimeResponse.season,
          dataAnimeResponse.broadcast?.day,
          dataAnimeResponse.broadcast?.time,
          dataAnimeResponse.broadcast?.timezone,
          dataAnimeResponse.producers
              ?.map((otherItemResponse) =>
                  _otherItemResponseToStudioData(otherItemResponse))
              .toList(),
          dataAnimeResponse.licensors
              ?.map((otherItemResponse) =>
                  _otherItemResponseToStudioData(otherItemResponse))
              .toList(),
          dataAnimeResponse.studios
              ?.map((otherItemResponse) =>
                  _otherItemResponseToStudioData(otherItemResponse))
              .toList(),
          <GenreData>[
            ...?dataAnimeResponse.genres
                ?.map((otherItemResponse) =>
                    _otherItemResponseToGenreData(otherItemResponse))
                .toList(),
            ...?dataAnimeResponse.themes
                ?.map((otherItemResponse) =>
                    _otherItemResponseToGenreData(otherItemResponse))
                .toList(),
            ...?dataAnimeResponse.demographics
                ?.map((otherItemResponse) =>
                    _otherItemResponseToGenreData(otherItemResponse))
                .toList()
          ]);

  StudioData _otherItemResponseToStudioData(
          OtherItemResponse otherItemResponse) =>
      StudioData(otherItemResponse.malId, otherItemResponse.type,
          otherItemResponse.name, otherItemResponse.url);

  GenreData _otherItemResponseToGenreData(
          OtherItemResponse otherItemResponse) =>
      GenreData(otherItemResponse.malId, otherItemResponse.type,
          otherItemResponse.name, otherItemResponse.url);

  PaginationData _paginationResponseToPaginationData(
          PaginationResponse paginationResponse) =>
      PaginationData(
        paginationResponse.lastVisiblePage,
        paginationResponse.hasNextPage,
        paginationResponse.currentPage,
        paginationResponse.items?.count,
        paginationResponse.items?.total,
        paginationResponse.items?.perPage,
      );
}
