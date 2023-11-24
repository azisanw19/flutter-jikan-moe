import 'package:anime_list/src/data/repository/base/base_repository_local.dart';
import 'package:anime_list/src/domain/dto/anime/anime_extension.dart';
import 'package:anime_list/src/domain/dto/anime/genre_extension.dart';
import 'package:anime_list/src/domain/dto/anime/studio_extension.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';

import '../../domain/local/entity/anime/anime_entity.dart';
import '../../domain/local/entity/anime/anime_table.dart';
import '../../domain/local/entity/anime/genre_entity.dart';
import '../../domain/local/entity/anime/relation_genre_and_anime_entity.dart';
import '../../domain/local/entity/anime/relation_licensor_and_anime_entity.dart';
import '../../domain/local/entity/anime/relation_producer_and_anime_entity.dart';
import '../../domain/local/entity/anime/relation_season_now_and_anime_entity.dart';
import '../../domain/local/entity/anime/relation_studio_and_anime_entity.dart';
import '../../domain/local/entity/anime/relation_title_synonym_and_anime.dart';
import '../../domain/local/entity/anime/studio_entity.dart';
import '../../domain/local/models/anime/anime_data.dart';
import '../../domain/local/models/anime/genre_data.dart';
import '../../domain/local/models/anime/studio_data.dart';
import '../data_source/local/dao/anime_dao.dart';

class AnimeRepositoryLocalImpl extends BaseRepositoryLocal
    implements AnimeRepositoryLocal {
  final AnimeDao _animeDao;

  AnimeRepositoryLocalImpl(this._animeDao);

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
      listAnimeEntity.add(animeData.toAnimeEntity());

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
                RelationTitleSynonymAndAnime(
                    animeData.malId!, titleSynonym)));

      if (animeData.producers != null)
        listRelationProducerAndAnimeEntity.addAll(animeData.producers!.map(
            (studioData) =>
                RelationProducerAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.licensors != null)
        listRelationLicensorAndAnimeEntity.addAll(animeData.licensors!.map(
            (studioData) => RelationLicensorAndAnimeEntity(
                studioData.malId!, animeData.malId!)));

      if (animeData.studios != null)
        listRelationStudioAndAnimeEntity.addAll(animeData.studios!.map(
            (studioData) =>
                RelationStudioAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.genres != null)
        listRelationGenreAndAnimeEntity.addAll(animeData.genres!.map(
            (genreData) =>
                RelationGenreAndAnimeEntity(
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

    List<AnimeData> listAnimeData = dataStateListAnime.data!
        .map((animeTable) => animeTable.toAnimeData())
        .toList();
    return DataStateSuccess(listAnimeData);
  }

  @override
  Future<DataState<void>> saveAnimeThisSeason(
      List<AnimeData> listAnimeData) async {
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
    List<RelationSeasonNowAndAnimeEntity> listRelationSeasonNowAndAnimeEntity =
        <RelationSeasonNowAndAnimeEntity>[];

    listAnimeData.forEach((animeData) {
      listAnimeEntity.add(animeData.toAnimeEntity());

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
                RelationTitleSynonymAndAnime(
                    animeData.malId!, titleSynonym)));

      if (animeData.producers != null)
        listRelationProducerAndAnimeEntity.addAll(animeData.producers!.map(
            (studioData) =>
                RelationProducerAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.licensors != null)
        listRelationLicensorAndAnimeEntity.addAll(animeData.licensors!.map(
            (studioData) => RelationLicensorAndAnimeEntity(
                studioData.malId!, animeData.malId!)));

      if (animeData.studios != null)
        listRelationStudioAndAnimeEntity.addAll(animeData.studios!.map(
            (studioData) =>
                RelationStudioAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.genres != null)
        listRelationGenreAndAnimeEntity.addAll(animeData.genres!.map(
            (genreData) =>
                RelationGenreAndAnimeEntity(
                    genreData.malId!, animeData.malId!)));

      if (animeData.malId != null)
        listRelationSeasonNowAndAnimeEntity
            .add(RelationSeasonNowAndAnimeEntity(animeData.malId!));
    });

    return await _insertAnimeSeasonNowTransaction(
        listAnimeEntity,
        listStudioEntity,
        listGenreEntity,
        listRelationTitleSynonymAndAnime,
        listRelationProducerAndAnimeEntity,
        listRelationLicensorAndAnimeEntity,
        listRelationStudioAndAnimeEntity,
        listRelationGenreAndAnimeEntity,
        listRelationSeasonNowAndAnimeEntity);
  }

  @override
  Future<DataState<List<AnimeData>>> getListAnimeSeasonNow(
      int limit, int offset) async {
    DataState<List<AnimeTable>> dataStateListAnime =
        await _getAnimeTableSeasonNow(limit, offset);

    if (dataStateListAnime is DataStateError)
      return DataStateError(dataStateListAnime.exception!);

    List<AnimeData> listAnimeData = dataStateListAnime.data!
        .map((animeTable) => animeTable.toAnimeData())
        .toList();
    return DataStateSuccess(listAnimeData);
  }

  @override
  Future<DataState<void>> deleteAnimeThisSeason() => _clearAnimeThisSeason();

  Iterable<StudioEntity> _extractStudioDataToStudioEntity(
          List<StudioData> listStudioData) =>
      listStudioData.map((studioData) => studioData.toStudioEntity());

  Iterable<GenreEntity> _extractGenreDataToGenreEntity(
          List<GenreData> listGenreData) =>
      listGenreData.map((genreData) => genreData.toGenreEntity());

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

  Future<DataState<void>> _insertAnimeSeasonNowTransaction(
          List<AnimeEntity> listAnimeEntity,
          List<StudioEntity> listStudioEntity,
          List<GenreEntity> listGenreEntity,
          List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime,
          List<RelationProducerAndAnimeEntity>
              listRelationProducerAndAnimeEntity,
          List<RelationLicensorAndAnimeEntity>
              listRelationLicensorAndAnimeEntity,
          List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity,
          List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity,
          List<RelationSeasonNowAndAnimeEntity>
              listRelationSeasonNowAndAnimeEntity) =>
      getStateOf(
          request: () => _animeDao.insertAnimeAndSeasonNowTransaction(
              listAnimeEntity,
              listStudioEntity,
              listGenreEntity,
              listRelationTitleSynonymAndAnime,
              listRelationProducerAndAnimeEntity,
              listRelationLicensorAndAnimeEntity,
              listRelationStudioAndAnimeEntity,
              listRelationGenreAndAnimeEntity,
              listRelationSeasonNowAndAnimeEntity));

  Future<DataState<List<AnimeTable>>> _getAnimeTable() =>
      getStateOf(request: () => _animeDao.getAnimeTable());

  Future<DataState<List<AnimeTable>>> _getAnimeTableSeasonNow(
          int limit, int offset) =>
      getStateOf(
          request: () => _animeDao.getAnimeTableSeasonNow(limit, offset));

  Future<DataState<void>> _clearAnimeThisSeason() =>
      getStateOf(request: () => _animeDao.clearAnimeSeasonNow());
}
