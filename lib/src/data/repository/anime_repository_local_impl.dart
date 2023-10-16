import 'package:anime_list/src/data/repository/base/base_repository_local.dart';
import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';

import '../data_source/local/dao/anime_dao.dart';

class AnimeRepositoryLocalImpl extends BaseRepositoryLocal
    implements AnimeRepositoryLocal {
  final AnimeDao _animeDao;

  AnimeRepositoryLocalImpl(this._animeDao);

  @override
  Future<DataState<int>> clearAnimeRows() {
    Future<DataState<int>> futureDataStateNumberOfEffectedRow =
    getStateOf(request: () => _animeDao.clearAnimeRows());

    return futureDataStateNumberOfEffectedRow;
  }

  @override
  Future<DataState<void>> saveAnime(List<AnimeData> listAnimeData) async {
    List<AnimeEntity> listAnimeEntity = <AnimeEntity>[];
    List<StudioEntity> listStudioEntity = <StudioEntity>[];
    
    listAnimeData.forEach((animeData) {
      listAnimeEntity.add(_animeDataToAnimeEntity(animeData));
      
    });

    // insert anime
    DataState<int> dataStateInsertAnime = await insertAnime(
        listAnimeEntity);

    if (dataStateInsertAnime is DataStateError) {
      return DataStateError(dataStateInsertAnime.exception!);
    }

    
    // insert studio
    DataState<int> dataStateInsertStudio = await insertStudio(
        listStudioEntity);
    
    if (dataStateInsertStudio is DataStateError) {
      return DataStateError(dataStateInsertStudio.exception!);
    }

    return DataStateSuccess(null);
  }

  @override
  Stream<List<AnimeData>> getListAnime() {
    throw UnimplementedError();
  }

  Future<DataState<int>> insertAnime(List<AnimeEntity> listAnimeEntity) =>
      getStateOf(request: () => _animeDao.insertAnime(listAnimeEntity));

  Future<DataState<int>> insertStudio(List<StudioEntity> listStudioEntity) =>
      getStateOf(request: () => _animeDao.insertStudio(listStudioEntity));


  // DTO to anime entity
  AnimeEntity _animeDataToAnimeEntity(AnimeData animeData) =>
      AnimeEntity(
        animeData.malId!,
        animeData.url,
        animeData.image,
        animeData.youtubeTrailerId,
        animeData.youtubeTrailerImage,
        animeData.titleDefault,
        animeData.titleEnglish,
        animeData.titleJapanese,
        animeData.type,
        animeData.source,
        animeData.episodes,
        animeData.status,
        animeData.airing,
        animeData.airedFrom,
        animeData.airedTo,
        animeData.duration,
        animeData.rating,
        animeData.score,
        animeData.scoredBy,
        animeData.rank,
        animeData.popularity,
        animeData.favorite,
        animeData.synopsis,
        animeData.background,
        animeData.season,
        animeData.broadcastDay,
        animeData.broadcastTime,
        animeData.broadcastTimezone,
      );
}
