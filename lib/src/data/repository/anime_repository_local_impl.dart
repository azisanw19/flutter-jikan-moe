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
  Future<DataState<int>> clearAnimeRows() {
    Future<DataState<int>> futureDataStateNumberOfEffectedRow =
        getStateOf(request: () => _animeDao.clearAnimeRows());

    return futureDataStateNumberOfEffectedRow;
  }

  @override
  Future<DataState<void>> saveAnime(List<AnimeData> listAnimeData) async {
    List<AnimeEntity> listAnimeEntity = <AnimeEntity>[];
    late Iterable<RelationTitleSynonymAndAnime>
        iterableRelationTitleSynonymAndAnime;
    late Iterable<StudioEntity> iterableStudioEntityProducer;
    late Iterable<StudioEntity> iterableStudioEntityLicensor;
    late Iterable<StudioEntity> iterableStudioEntityStudio;
    late Iterable<GenreEntity> iterableGenreEntity;
    late Iterable<RelationProducerAndAnimeEntity>
        iterableRelationProducerAndAnimeEntity;
    late Iterable<RelationLicensorAndAnimeEntity>
        iterableRelationLicensorAndAnimeEntity;
    late Iterable<RelationStudioAndAnimeEntity>
        iterableRelationStudioAndAnimeEntity;
    late Iterable<RelationGenreAndAnimeEntity>
        iterableRelationGenreAndAnimeEntity;

    listAnimeData.forEach((animeData) {
      listAnimeEntity.add(_animeDataToAnimeEntity(animeData));

      // data title synonym
      if (animeData.titleSynonyms != null)
        iterableRelationTitleSynonymAndAnime = animeData.titleSynonyms!.map(
            (titleSynonym) =>
                _titleSynonymAndMalIdAnimeToRelationTitleSynonymAndAnimeEntity(
                    animeData.malId!, titleSynonym));

      // data producer
      if (animeData.producers != null) {
        iterableStudioEntityProducer =
            _extractStudioDataToStudioEntity(animeData.producers!);

        iterableRelationProducerAndAnimeEntity =
            iterableStudioEntityProducer.map((studioEntity) =>
                _studioProducerAndAnimeToRelationProducerAndAnimeEntity(
                    animeData.malId!, studioEntity.malId));
      }

      // data licensor
      if (animeData.licensors != null) {
        iterableStudioEntityLicensor =
            _extractStudioDataToStudioEntity(animeData.licensors!);

        iterableRelationLicensorAndAnimeEntity =
            iterableStudioEntityLicensor.map((studioData) =>
                _studioLicensorAndAnimeToRelationLicensorAndAnime(
                    animeData.malId!, studioData.malId));
      }

      // data studio
      if (animeData.studios != null) {
        iterableStudioEntityStudio =
            _extractStudioDataToStudioEntity(animeData.studios!);

        iterableRelationStudioAndAnimeEntity = iterableStudioEntityStudio.map(
            (studioData) => _studioAndAnimeToRelationStudioAndAnimeEntity(
                animeData.malId!, studioData.malId));
      }

      if (animeData.genres != null) {
        iterableGenreEntity = _extractGenreDataToGenreEntity(animeData.genres!);

        iterableRelationGenreAndAnimeEntity = iterableGenreEntity.map(
            (genreEntity) => _genreAndAnimeToRelationGenreAndAnimeEntity(
                animeData.malId!, genreEntity.malId));
      }
    });

    // insert anime
    DataState<int> dataStateInsertAnime = await _insertAnime(listAnimeEntity);

    if (dataStateInsertAnime is DataStateError) {
      return DataStateError(dataStateInsertAnime.exception!);
    }

    // insert studio
    List<StudioEntity> listStudioEntity = [
      ...iterableStudioEntityProducer,
      ...iterableStudioEntityLicensor,
      ...iterableStudioEntityStudio
    ];
    DataState<int> dataStateInsertStudio =
        await _insertStudio(listStudioEntity);

    if (dataStateInsertStudio is DataStateError) {
      return DataStateError(dataStateInsertStudio.exception!);
    }

    // insert genre
    DataState<int> dataStateInsertGenre =
        await _insertGenre(iterableGenreEntity.toList());

    if (dataStateInsertGenre is DataStateError) {
      return DataStateError(dataStateInsertGenre.exception!);
    }

    // insert relation title synonym and anime
    DataState<int> dataStateRelationTitleSynonym =
        await _insertRelationTitleSynonym(
            iterableRelationTitleSynonymAndAnime.toList());

    if (dataStateRelationTitleSynonym is DataStateError) {
      return DataStateError(dataStateRelationTitleSynonym.exception!);
    }

    // insert relation producer and anime
    DataState<int> dataStateRelationProducerAndAnime =
        await _insertRelationProducerAndAnime(
            iterableRelationProducerAndAnimeEntity.toList());

    if (dataStateRelationProducerAndAnime is DataStateError) {
      return DataStateError(dataStateRelationProducerAndAnime.exception!);
    }

    // insert relation licensor and anime
    DataState<int> dataStateRelationLicensorAndAnime =
        await _insertRelationLicensorAndAnime(
            iterableRelationLicensorAndAnimeEntity.toList());

    if (dataStateRelationLicensorAndAnime is DataStateError) {
      return DataStateError(dataStateRelationLicensorAndAnime.exception!);
    }

    // insert relation studio and anime
    DataState<int> dataStateStudioLicensorAndAnime =
        await _insertRelationStudioAndAnime(
            iterableRelationStudioAndAnimeEntity.toList());

    if (dataStateStudioLicensorAndAnime is DataStateError) {
      return DataStateError(dataStateStudioLicensorAndAnime.exception!);
    }

    // insert relation genre and anime
    DataState<int> dataStateGenreAndAnime = await _insertRelationGenreAndAnime(
        iterableRelationGenreAndAnimeEntity.toList());

    if (dataStateGenreAndAnime is DataStateError) {
      return DataStateError(dataStateGenreAndAnime.exception!);
    }

    return DataStateSuccess(null);
  }

  @override
  Stream<List<Future<AnimeData>>> getListAnime() {
    Stream<List<AnimeEntity>?> listAnimeEntity = _getAnime();

    return listAnimeEntity
        .where((listAnimeEntity) => listAnimeEntity != null)
        .map((listAnimeEntity) =>
            listAnimeEntity!.map(_extractAnimeEntityToAnimeData).toList());
  }

  Future<AnimeData> _extractAnimeEntityToAnimeData(
      AnimeEntity animeEntity) async {
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

  Future<DataState<int>> _insertAnime(List<AnimeEntity> listAnimeEntity) =>
      getStateOf(request: () => _animeDao.insertAnime(listAnimeEntity));

  Future<DataState<int>> _insertStudio(List<StudioEntity> listStudioEntity) =>
      getStateOf(request: () => _animeDao.insertStudio(listStudioEntity));

  Future<DataState<int>> _insertGenre(List<GenreEntity> listGenreEntity) =>
      getStateOf(request: () => _animeDao.insertGenre(listGenreEntity));

  Future<DataState<int>> _insertRelationTitleSynonym(
          List<RelationTitleSynonymAndAnime>
              listRelationTitleSynonymAndAnime) =>
      getStateOf(
          request: () => _animeDao
              .insertRelationTitleSynonym(listRelationTitleSynonymAndAnime));

  Future<DataState<int>> _insertRelationProducerAndAnime(
          List<RelationProducerAndAnimeEntity>
              listRelationProducerAndAnimeEntity) =>
      getStateOf(
          request: () => _animeDao.insertRelationProducerAndAnime(
              listRelationProducerAndAnimeEntity));

  Future<DataState<int>> _insertRelationLicensorAndAnime(
          List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnime) =>
      getStateOf(
          request: () => _animeDao
              .insertRelationLicensorAndAnime(listRelationLicensorAndAnime));

  Future<DataState<int>> _insertRelationStudioAndAnime(
          List<RelationStudioAndAnimeEntity> listRelationStudioAndAnime) =>
      getStateOf(
          request: () => _animeDao
              .insertRelationStudioAndAnime(listRelationStudioAndAnime));

  Future<DataState<int>> _insertRelationGenreAndAnime(
          List<RelationGenreAndAnimeEntity> listRelationGenreAndAnime) =>
      getStateOf(
          request: () =>
              _animeDao.insertRelationGenreAndAnime(listRelationGenreAndAnime));

  Stream<List<AnimeEntity>?> _getAnime() => _animeDao.getAnime();

  Future<DataState<List<RelationTitleSynonymAndAnime>?>>
      _getRelationTitleSynonymAndAnime(int malIdAnime) => getStateOf(
          request: () => _animeDao.getRelationTitleSynonymAndAnime(malIdAnime));

  Future<DataState<List<RelationProducerAndAnimeEntity>?>>
      _getRelationProducerAndAnime(int malIdAnime) => getStateOf(
          request: () => _animeDao.getRelationProducerAndAnime(malIdAnime));

  Future<DataState<StudioEntity?>> _getStudioFromId(int malIdStudio) =>
      getStateOf(request: () => _animeDao.getStudioFromId(malIdStudio));

  Future<DataState<List<RelationLicensorAndAnimeEntity>?>>
      _getRelationLicensorAndAnime(int malIdAnime) => getStateOf(
          request: () => _animeDao.getRelationLicensorAndAnime(malIdAnime));

  Future<DataState<List<RelationStudioAndAnimeEntity>?>>
      _getRelationStudioAndAnime(int malIdAnime) => getStateOf(
          request: () => _animeDao.getRelationStudioAndAnime(malIdAnime));

  Future<DataState<List<RelationGenreAndAnimeEntity>?>>
      _getRelationGenreAndAnime(int malIdAnime) => getStateOf(
          request: () => _animeDao.getRelationGenreAndAnime(malIdAnime));

  Future<DataState<GenreEntity?>> _getGenreFromId(int malIdGenre) =>
      getStateOf(request: () => _animeDao.getGenreFromId(malIdGenre));

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
      _studioProducerAndAnimeToRelationProducerAndAnimeEntity(
              int malIdAnime, int malIdStudio) =>
          RelationProducerAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation licensor and anime
  RelationLicensorAndAnimeEntity
      _studioLicensorAndAnimeToRelationLicensorAndAnime(
              int malIdAnime, int malIdStudio) =>
          RelationLicensorAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation studio and anime
  RelationStudioAndAnimeEntity _studioAndAnimeToRelationStudioAndAnimeEntity(
          int malIdAnime, int malIdStudio) =>
      RelationStudioAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO relation genre and anime
  RelationGenreAndAnimeEntity _genreAndAnimeToRelationGenreAndAnimeEntity(
          int malIdAnime, int malIdStudio) =>
      RelationGenreAndAnimeEntity(malIdAnime, malIdStudio);

  // DTO anime entity to anime data
  AnimeData _animeEntityToAnimeData(
          AnimeEntity animeEntity,
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
  StudioData _studioEntityToStudioData(StudioEntity studioEntity) => StudioData(
      studioEntity.malId,
      studioEntity.type,
      studioEntity.name,
      studioEntity.url);

  // DTO genre entity and anime to studio data
  GenreData _genreEntityToGenreData(GenreEntity genreEntity) => GenreData(
      genreEntity.malId, genreEntity.type, genreEntity.name, genreEntity.url);
}
