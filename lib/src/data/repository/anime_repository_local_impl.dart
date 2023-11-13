import 'package:anime_list/src/data/repository/base/base_repository_local.dart';
import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/domain/data_transfer_object/genre_data.dart';
import 'package:anime_list/src/domain/data_transfer_object/studio_data.dart';
import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/anime_table.dart';
import 'package:anime_list/src/domain/local/models/anime/genre_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_genre_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_licensor_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_producer_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_studio_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';

import '../../domain/local/models/anime/relation_title_synonym_and_anime.dart';
import '../data_source/local/dao/anime_dao.dart';

class AnimeRepositoryLocalImpl extends BaseRepositoryLocal
    implements AnimeRepositoryLocal {
  final AnimeDao _animeDao;

  AnimeRepositoryLocalImpl(this._animeDao);

  @override
  Future<DataState<int?>> clearAnimeRows() {
    Future<DataState<int?>> futureDataStateNumberOfEffectedRow =
        getStateOf(request: () => _animeDao.clearAnimeRows());

    return futureDataStateNumberOfEffectedRow;
  }

  @override
  Future<DataState<void>> saveAnime(List<AnimeData> listAnimeData) async {
    List<AnimeEntity> listAnimeEntity = <AnimeEntity>[];
    List<StudioEntity> listStudioEntity = <StudioEntity>[];
    List<GenreEntity> listGenreEntity = <GenreEntity>[];
    List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime =
        <RelationTitleSynonymAndAnime>[];
    List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity =
        <RelationProducerAndAnimeEntity>[];
    List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity =
        <RelationLicensorAndAnimeEntity>[];
    List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity =
        <RelationStudioAndAnimeEntity>[];
    List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity =
        <RelationGenreAndAnimeEntity>[];

    listAnimeData.forEach((animeData) {
      listAnimeEntity.add(_animeDataToAnimeEntity(animeData));

      if (animeData.producers != null)
        listStudioEntity
            .addAll(_extractStudioDataToStudioEntity(animeData.producers!));
      if (animeData.licensors != null)
        listStudioEntity
            .addAll(_extractStudioDataToStudioEntity(animeData.licensors!));
      if (animeData.studios != null)
        listStudioEntity
            .addAll(_extractStudioDataToStudioEntity(animeData.studios!));
      if (animeData.genres != null)
        listGenreEntity
            .addAll(_extractGenreDataToGenreEntity(animeData.genres!));

      if (animeData.titleSynonyms != null)
        listRelationTitleSynonymAndAnime.addAll(animeData.titleSynonyms!.map(
            (titleSynonym) =>
                _titleSynonymAndMalIdAnimeToRelationTitleSynonymAndAnimeEntity(
                    animeData.malId!, titleSynonym)));

      if (animeData.producers != null)
        listRelationProducerAndAnimeEntity.addAll(animeData.producers!.map(
            (studioData) =>
                _malIdStudioEntityAndMalIdAnimeToRelationProducerAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.licensors != null)
        listRelationLicensorAndAnimeEntity.addAll(animeData.licensors!.map(
            (studioData) => _malIdStudioAndMalIdAnimeToRelationLicensorAndAnime(
                studioData.malId!, animeData.malId!)));

      if (animeData.studios != null)
        listRelationStudioAndAnimeEntity.addAll(animeData.studios!.map(
            (studioData) =>
                _malIdStudioAndMalIdAnimeToRelationStudioAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.genres != null)
        listRelationGenreAndAnimeEntity.addAll(animeData.genres!.map(
            (genreData) =>
                _malIdGenreAndMalIdAnimeToRelationGenreAndAnimeEntity(
                    genreData.malId!, animeData.malId!)));
    });

    return await _insertAnimeTransaction(
        listAnimeEntity,
        listStudioEntity,
        listGenreEntity,
        listRelationTitleSynonymAndAnime,
        listRelationProducerAndAnimeEntity,
        listRelationLicensorAndAnimeEntity,
        listRelationStudioAndAnimeEntity,
        listRelationGenreAndAnimeEntity);
  }

  @override
  Future<DataState<List<AnimeData>>> getListAnime() async {
    DataState<List<AnimeTable>> dataStateListAnime = await _getAnimeTable();

    if (dataStateListAnime is DataStateError)
      return DataStateError(dataStateListAnime.exception!);

    List<AnimeData> listAnimeData =
        dataStateListAnime.data!.map(_animeTableToAnimeData).toList();
    return DataStateSuccess(listAnimeData);
  }

  Iterable<StudioEntity> _extractStudioDataToStudioEntity(
          List<StudioData> listStudioData) =>
      listStudioData.map((studioData) => _studioDataToStudioEntity(studioData));

  Iterable<GenreEntity> _extractGenreDataToGenreEntity(
          List<GenreData> listGenreData) =>
      listGenreData.map(_genreDataToGenreEntity);

  Future<DataState<void>> _insertAnimeTransaction(
          List<AnimeEntity> listAnimeEntity,
          List<StudioEntity> listStudioEntity,
          List<GenreEntity> listGenreEntity,
          List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime,
          List<RelationProducerAndAnimeEntity>
              listRelationProducerAndAnimeEntity,
          List<RelationLicensorAndAnimeEntity>
              listRelationLicensorAndAnimeEntity,
          List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity,
          List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity) =>
      getStateOf(
          request: () => _animeDao.insertAnimeTransaction(
              listAnimeEntity,
              listStudioEntity,
              listGenreEntity,
              listRelationTitleSynonymAndAnime,
              listRelationProducerAndAnimeEntity,
              listRelationLicensorAndAnimeEntity,
              listRelationStudioAndAnimeEntity,
              listRelationGenreAndAnimeEntity));

  Future<DataState<List<AnimeTable>>> _getAnimeTable() =>
      getStateOf(request: () => _animeDao.getAnimeTable());

  // DTO to anime entity
  AnimeEntity _animeDataToAnimeEntity(AnimeData animeData) => AnimeEntity(
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

  // DTO to studio entity
  StudioEntity _studioDataToStudioEntity(StudioData studioData) => StudioEntity(
      studioData.malId!, studioData.type, studioData.name, studioData.url);

  // DTO to genre entity
  GenreEntity _genreDataToGenreEntity(GenreData genreData) => GenreEntity(
      genreData.malId!, genreData.type, genreData.name, genreData.url);

  // DTO relation title synonym and anime
  RelationTitleSynonymAndAnime
      _titleSynonymAndMalIdAnimeToRelationTitleSynonymAndAnimeEntity(
              int malIdAnime, String titleSynonym) =>
          RelationTitleSynonymAndAnime(malIdAnime, titleSynonym);

  // DTO relation producer and anime
  RelationProducerAndAnimeEntity
      _malIdStudioEntityAndMalIdAnimeToRelationProducerAndAnimeEntity(
              int malIdStudio, int malIdAnime) =>
          RelationProducerAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation licensor and anime
  RelationLicensorAndAnimeEntity
      _malIdStudioAndMalIdAnimeToRelationLicensorAndAnime(
              int malIdStudio, int malIdAnime) =>
          RelationLicensorAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation studio and anime
  RelationStudioAndAnimeEntity
      _malIdStudioAndMalIdAnimeToRelationStudioAndAnimeEntity(
              int malIdStudio, int malIdAnime) =>
          RelationStudioAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation genre and anime
  RelationGenreAndAnimeEntity
      _malIdGenreAndMalIdAnimeToRelationGenreAndAnimeEntity(
              int malIdGenre, int malIdAnime) =>
          RelationGenreAndAnimeEntity(malIdAnime, malIdGenre);

  // DTO studio entity and anime to studio data
  StudioData _studioEntityToStudioData(StudioEntity studioEntity) => StudioData(
      studioEntity.malId,
      studioEntity.type,
      studioEntity.name,
      studioEntity.url);

  // DTO genre entity and anime to studio data
  GenreData _genreEntityToGenreData(GenreEntity genreEntity) => GenreData(
      genreEntity.malId, genreEntity.type, genreEntity.name, genreEntity.url);

  // DTO anime table to anime data
  AnimeData _animeTableToAnimeData(AnimeTable animeTable) => AnimeData(
        animeTable.animeEntity.malId,
        animeTable.animeEntity.url,
        animeTable.animeEntity.image,
        animeTable.animeEntity.youtubeTrailerId,
        animeTable.animeEntity.youtubeTrailerImage,
        animeTable.animeEntity.titleDefault,
        animeTable.animeEntity.titleEnglish,
        animeTable.animeEntity.titleJapanese,
        animeTable.listTitleSynonym,
        animeTable.animeEntity.type,
        animeTable.animeEntity.source,
        animeTable.animeEntity.episodes,
        animeTable.animeEntity.status,
        animeTable.animeEntity.airing,
        animeTable.animeEntity.airedFrom,
        animeTable.animeEntity.airedTo,
        animeTable.animeEntity.duration,
        animeTable.animeEntity.rating,
        animeTable.animeEntity.score,
        animeTable.animeEntity.scoredBy,
        animeTable.animeEntity.rank,
        animeTable.animeEntity.popularity,
        animeTable.animeEntity.favorite,
        animeTable.animeEntity.synopsis,
        animeTable.animeEntity.background,
        animeTable.animeEntity.season,
        animeTable.animeEntity.broadcastDay,
        animeTable.animeEntity.broadcastTime,
        animeTable.animeEntity.broadcastTimezone,
        animeTable.listProducerStudio
            .map((studioEntity) => _studioEntityToStudioData(studioEntity))
            .toList(),
        animeTable.listLicensorStudio
            .map((studioEntity) => _studioEntityToStudioData(studioEntity))
            .toList(),
        animeTable.listStudio
            .map((studioEntity) => _studioEntityToStudioData(studioEntity))
            .toList(),
        animeTable.listGenre
            .map((genreEntity) => _genreEntityToGenreData(genreEntity))
            .toList(),
      );
}
