import 'package:anime_list/src/data/repository/base/base_repository_local.dart';
import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/domain/data_transfer_object/genre_data.dart';
import 'package:anime_list/src/domain/data_transfer_object/studio_data.dart';
import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
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
    List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity = <
        RelationProducerAndAnimeEntity>[];
    List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity = <
        RelationLicensorAndAnimeEntity>[];
    List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity = <
        RelationStudioAndAnimeEntity>[];
    List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity = <
        RelationGenreAndAnimeEntity>[];

    listAnimeData.forEach((animeData) {
      listAnimeEntity.add(_animeDataToAnimeEntity(animeData));

      if (animeData.producers != null)
        listStudioEntity.addAll(
            _extractStudioDataToStudioEntity(animeData.producers!));
      if (animeData.licensors != null)
        listStudioEntity.addAll(
            _extractStudioDataToStudioEntity(animeData.licensors!));
      if (animeData.studios != null)
        listStudioEntity.addAll(
            _extractStudioDataToStudioEntity(animeData.studios!));
      if (animeData.genres != null)
        listGenreEntity.addAll(
            _extractGenreDataToGenreEntity(animeData.genres!));

      if (animeData.titleSynonyms != null)
        listRelationTitleSynonymAndAnime.addAll(animeData.titleSynonyms!.map(
                (titleSynonym) =>
                _titleSynonymAndMalIdAnimeToRelationTitleSynonymAndAnimeEntity(
                    animeData.malId!, titleSynonym)));

      if (animeData.producers != null)
        listRelationProducerAndAnimeEntity.addAll(
            animeData.producers!.map((studioData) =>
                _malIdStudioEntityAndMalIdAnimeToRelationProducerAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.licensors != null)
        listRelationLicensorAndAnimeEntity.addAll
          (animeData.licensors!.map((studioData) =>
            _malIdStudioAndMalIdAnimeToRelationLicensorAndAnime(
                studioData.malId!, animeData.malId!)));

      if (animeData.studios != null)
        listRelationStudioAndAnimeEntity.addAll
          (animeData.studios!.map(
                (studioData) =>
                _malIdStudioAndMalIdAnimeToRelationStudioAndAnimeEntity(
                    studioData.malId!, animeData.malId!)));

      if (animeData.genres != null)
        listRelationGenreAndAnimeEntity.addAll
          (animeData.genres!.map(
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
  Stream<List<AnimeData>> getListAnime() {
    Stream<List<AnimeEntity>?> listAnimeEntity = _getAnime();

    Stream<List<AnimeEntity>> listAnimeEntityNotNull = listAnimeEntity
        .where((listAnimeEntityNullable) => listAnimeEntityNullable != null)
        .map((animeEntityNotNull) => animeEntityNotNull!);

    return listAnimeEntityNotNull.map(_extractListAnimeEntityToListAnimeData);
  }

  List<AnimeData> _extractListAnimeEntityToListAnimeData(
      List<AnimeEntity> listAnimeEntity) {
    List<AnimeData> listAnimeData = <AnimeData>[];

    listAnimeEntity.forEach((animeEntity) async {
      listAnimeData.add(await _extractAnimeEntityToAnimeData(animeEntity));
    });

    return listAnimeData;
  }

  Future<AnimeData> _extractAnimeEntityToAnimeData(
      AnimeEntity animeEntity) async {
    print('Anime Entity id ${animeEntity.malId}');
    DataState<List<RelationTitleSynonymAndAnime>?>
    dataStateRelationTitleSynonymAndAnime =
    await _getRelationTitleSynonymAndAnime(animeEntity.malId);

    // title synonym
    late List<String> listTitleSynonym;
    if (dataStateRelationTitleSynonymAndAnime is DataStateSuccess) {
      listTitleSynonym = dataStateRelationTitleSynonymAndAnime.data!
          .map((relationTitleSynonymAndAnime) =>
          _relationTitleSynonymAndAnimeToListString(
              relationTitleSynonymAndAnime))
          .toList();
    } else {
      listTitleSynonym = <String>[];
    }
    print(
        'anime id ${animeEntity
            .malId} Relation Title Synonym and Anime $listTitleSynonym');

    // producer studio
    DataState<List<RelationProducerAndAnimeEntity>?>
    dataStateRelationProducerAndAnime =
    await _getRelationProducerAndAnime(animeEntity.malId);

    List<StudioData> producerStudioData = <StudioData>[];
    if (dataStateRelationProducerAndAnime is DataStateSuccess &&
        dataStateRelationProducerAndAnime.data != null) {
      dataStateRelationProducerAndAnime.data!
          .forEach((relationProducerAndAnimeEntity) async {
        StudioData? studioData =
        await _extractRelationProducerAndAnimeEntityToStudioData(
            relationProducerAndAnimeEntity);

        if (studioData != null) producerStudioData.add(studioData);
      });
    }
    print(
        'anime id ${animeEntity
            .malId} Relation producer and Anime $producerStudioData');

    // licensor studio
    DataState<List<RelationLicensorAndAnimeEntity>?>
    dataStateRelationLicensorAndAnime =
    await _getRelationLicensorAndAnime(animeEntity.malId);

    List<StudioData> licensorStudioData = <StudioData>[];
    if (dataStateRelationLicensorAndAnime is DataStateSuccess &&
        dataStateRelationLicensorAndAnime.data != null) {
      dataStateRelationLicensorAndAnime.data!
          .forEach((relationLicensorAndAnime) async {
        StudioData? studioData =
        await _extractRelationLicensorAndAnimeEntityToStudioData(
            relationLicensorAndAnime);

        if (studioData != null) licensorStudioData.add(studioData);
      });
    }
    print(
        'anime id ${animeEntity
            .malId} Relation liceonsor and Anime $producerStudioData');

    // studio
    DataState<List<RelationStudioAndAnimeEntity>?>
    dataStateRelationStudioAndAnime =
    await _getRelationStudioAndAnime(animeEntity.malId);

    List<StudioData> studioAnimeData = <StudioData>[];
    if (dataStateRelationStudioAndAnime is DataStateSuccess &&
        dataStateRelationStudioAndAnime.data != null) {
      dataStateRelationStudioAndAnime.data!
          .forEach((relationStudioAndAnimeEntity) async {
        StudioData? studioData =
        await _extractRelationStudioAndAnimeEntityToStudioData(
            relationStudioAndAnimeEntity);

        if (studioData != null) studioAnimeData.add(studioData);
      });
    }
    print(
        'anime id ${animeEntity
            .malId} Relation studio and Anime $producerStudioData');

    // genre
    DataState<List<RelationGenreAndAnimeEntity>?>
    dataStateRelationGenreAndAnime =
    await _getRelationGenreAndAnime(animeEntity.malId);

    List<GenreData> listGenreData = <GenreData>[];
    if (dataStateRelationGenreAndAnime is DataStateSuccess &&
        dataStateRelationGenreAndAnime.data != null) {
      dataStateRelationGenreAndAnime.data!
          .forEach((relationGenreAndAnimeEntity) async {
        GenreData? genreData =
        await _extractRelationGenreAndAnimeEntityToGenreData(
            relationGenreAndAnimeEntity);

        if (genreData != null) listGenreData.add(genreData);
      });
    }
    print(
        'anime id ${animeEntity
            .malId} Relation genre and Anime $producerStudioData');

    return _animeEntityToAnimeData(animeEntity, listTitleSynonym,
        producerStudioData, licensorStudioData, studioAnimeData, listGenreData);
  }

  Future<StudioData?> _extractRelationProducerAndAnimeEntityToStudioData(
      RelationProducerAndAnimeEntity relationProducerAndAnimeEntity) async {
    DataState<StudioEntity?> dataStateStudioEntity =
    await _getStudioFromId(relationProducerAndAnimeEntity.malIdStudio);

    if (dataStateStudioEntity is DataStateSuccess &&
        dataStateStudioEntity.data != null)
      return _studioEntityToStudioData(dataStateStudioEntity.data!);
    else
      return null;
  }

  Future<StudioData?> _extractRelationLicensorAndAnimeEntityToStudioData(
      RelationLicensorAndAnimeEntity relationLicensorAndAnimeEntity) async {
    DataState<StudioEntity?> dataStateStudioEntity =
    await _getStudioFromId(relationLicensorAndAnimeEntity.malIdStudio);

    if (dataStateStudioEntity is DataStateSuccess &&
        dataStateStudioEntity.data != null)
      return _studioEntityToStudioData(dataStateStudioEntity.data!);
    else
      return null;
  }

  Future<StudioData?> _extractRelationStudioAndAnimeEntityToStudioData(
      RelationStudioAndAnimeEntity relationStudioAndAnimeEntity) async {
    DataState<StudioEntity?> dataStateStudioEntity =
    await _getStudioFromId(relationStudioAndAnimeEntity.malIdStudio);

    if (dataStateStudioEntity is DataStateSuccess &&
        dataStateStudioEntity.data != null)
      return _studioEntityToStudioData(dataStateStudioEntity.data!);
    else
      return null;
  }

  Future<GenreData?> _extractRelationGenreAndAnimeEntityToGenreData(
      RelationGenreAndAnimeEntity relationGenreAndAnimeEntity) async {
    DataState<GenreEntity?> dataStateGenreEntity =
    await _getGenreFromId(relationGenreAndAnimeEntity.malIdGenre);

    if (dataStateGenreEntity is DataStateSuccess &&
        dataStateGenreEntity.data != null)
      return _genreEntityToGenreData(dataStateGenreEntity.data!);
    else
      return null;
  }

  Iterable<StudioEntity> _extractStudioDataToStudioEntity(
      List<StudioData> listStudioData) =>
      listStudioData.map((studioData) => _studioDataToStudioEntity(studioData));

  Iterable<GenreEntity> _extractGenreDataToGenreEntity(
      List<GenreData> listGenreData) =>
      listGenreData.map(_genreDataToGenreEntity);

  Future<DataState<void>> _insertAnimeTransaction(
      List<AnimeEntity> listAnimeEntity,
      List<StudioEntity> listStudioEntity, List<GenreEntity> listGenreEntity,
      List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime,
      List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity,
      List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity,
      List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity,
      List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity) =>
      getStateOf(request: () =>
          _animeDao.insertAnimeTransaction(
              listAnimeEntity,
              listStudioEntity,
              listGenreEntity,
              listRelationTitleSynonymAndAnime,
              listRelationProducerAndAnimeEntity,
              listRelationLicensorAndAnimeEntity,
              listRelationStudioAndAnimeEntity,
              listRelationGenreAndAnimeEntity
          ));

  Stream<List<AnimeEntity>?> _getAnime() => _animeDao.getAnime();

  Future<DataState<List<RelationTitleSynonymAndAnime>?>>
  _getRelationTitleSynonymAndAnime(int malIdAnime) =>
      getStateOf(
          request: () => _animeDao.getRelationTitleSynonymAndAnime(malIdAnime));

  Future<DataState<List<RelationProducerAndAnimeEntity>?>>
  _getRelationProducerAndAnime(int malIdAnime) =>
      getStateOf(
          request: () => _animeDao.getRelationProducerAndAnime(malIdAnime));

  Future<DataState<StudioEntity?>> _getStudioFromId(int malIdStudio) =>
      getStateOf(request: () => _animeDao.getStudioFromId(malIdStudio));

  Future<DataState<List<RelationLicensorAndAnimeEntity>?>>
  _getRelationLicensorAndAnime(int malIdAnime) =>
      getStateOf(
          request: () => _animeDao.getRelationLicensorAndAnime(malIdAnime));

  Future<DataState<List<RelationStudioAndAnimeEntity>?>>
  _getRelationStudioAndAnime(int malIdAnime) =>
      getStateOf(
          request: () => _animeDao.getRelationStudioAndAnime(malIdAnime));

  Future<DataState<List<RelationGenreAndAnimeEntity>?>>
  _getRelationGenreAndAnime(int malIdAnime) =>
      getStateOf(
          request: () => _animeDao.getRelationGenreAndAnime(malIdAnime));

  Future<DataState<GenreEntity?>> _getGenreFromId(int malIdGenre) =>
      getStateOf(request: () => _animeDao.getGenreFromId(malIdGenre));

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

  // DTO to studio entity
  StudioEntity _studioDataToStudioEntity(StudioData studioData) =>
      StudioEntity(
          studioData.malId!, studioData.type, studioData.name, studioData.url);

  // DTO to genre entity
  GenreEntity _genreDataToGenreEntity(GenreData genreData) =>
      GenreEntity(
          genreData.malId!, genreData.type, genreData.name, genreData.url);

  // DTO relation title synonym and anime
  RelationTitleSynonymAndAnime
  _titleSynonymAndMalIdAnimeToRelationTitleSynonymAndAnimeEntity(int malIdAnime,
      String titleSynonym) =>
      RelationTitleSynonymAndAnime(malIdAnime, titleSynonym);

  // DTO relation producer and anime
  RelationProducerAndAnimeEntity
  _malIdStudioEntityAndMalIdAnimeToRelationProducerAndAnimeEntity(
      int malIdStudio,
      int malIdAnime) =>
      RelationProducerAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation licensor and anime
  RelationLicensorAndAnimeEntity
  _malIdStudioAndMalIdAnimeToRelationLicensorAndAnime(int malIdStudio,
      int malIdAnime) =>
      RelationLicensorAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation studio and anime
  RelationStudioAndAnimeEntity _malIdStudioAndMalIdAnimeToRelationStudioAndAnimeEntity(
      int malIdStudio, int malIdAnime) =>
      RelationStudioAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation genre and anime
  RelationGenreAndAnimeEntity _malIdGenreAndMalIdAnimeToRelationGenreAndAnimeEntity(
      int malIdGenre, int malIdAnime) =>
      RelationGenreAndAnimeEntity(malIdAnime, malIdGenre);

  // DTO anime entity to anime data
  AnimeData _animeEntityToAnimeData(AnimeEntity animeEntity,
      List<String> titleSynonyms,
      List<StudioData> producers,
      List<StudioData> licensors,
      List<StudioData> studios,
      List<GenreData> genres) =>
      AnimeData(
        animeEntity.malId,
        animeEntity.url,
        animeEntity.image,
        animeEntity.youtubeTrailerId,
        animeEntity.youtubeTrailerImage,
        animeEntity.titleDefault,
        animeEntity.titleEnglish,
        animeEntity.titleJapanese,
        titleSynonyms,
        animeEntity.type,
        animeEntity.source,
        animeEntity.episodes,
        animeEntity.status,
        animeEntity.airing,
        animeEntity.airedFrom,
        animeEntity.airedTo,
        animeEntity.duration,
        animeEntity.rating,
        animeEntity.score,
        animeEntity.scoredBy,
        animeEntity.rank,
        animeEntity.popularity,
        animeEntity.favorite,
        animeEntity.synopsis,
        animeEntity.background,
        animeEntity.season,
        animeEntity.broadcastDay,
        animeEntity.broadcastTime,
        animeEntity.broadcastTimezone,
        producers,
        licensors,
        studios,
        genres,
      );

  // DTO string to relation title synonym and anime
  String _relationTitleSynonymAndAnimeToListString(
      RelationTitleSynonymAndAnime relationTitleSynonymAndAnime) =>
      relationTitleSynonymAndAnime.titleSynonym;

  // DTO studio entity and anime to studio data
  StudioData _studioEntityToStudioData(StudioEntity studioEntity) =>
      StudioData(
          studioEntity.malId,
          studioEntity.type,
          studioEntity.name,
          studioEntity.url);

  // DTO genre entity and anime to studio data
  GenreData _genreEntityToGenreData(GenreEntity genreEntity) =>
      GenreData(
          genreEntity.malId, genreEntity.type, genreEntity.name,
          genreEntity.url);
}
