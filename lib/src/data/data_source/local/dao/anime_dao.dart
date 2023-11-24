import 'package:floor/floor.dart';

import '../../../../domain/local/entity/anime/anime_entity.dart';
import '../../../../domain/local/entity/anime/anime_table.dart';
import '../../../../domain/local/entity/anime/genre_entity.dart';
import '../../../../domain/local/entity/anime/relation_genre_and_anime_entity.dart';
import '../../../../domain/local/entity/anime/relation_licensor_and_anime_entity.dart';
import '../../../../domain/local/entity/anime/relation_producer_and_anime_entity.dart';
import '../../../../domain/local/entity/anime/relation_season_now_and_anime_entity.dart';
import '../../../../domain/local/entity/anime/relation_studio_and_anime_entity.dart';
import '../../../../domain/local/entity/anime/relation_title_synonym_and_anime.dart';
import '../../../../domain/local/entity/anime/studio_entity.dart';
import '../../../../utils/constants/table_database_anime.dart';

@dao // data access object
abstract class AnimeDao {
  // insert data
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAnime(List<AnimeEntity> listAnimeEntity); // return id

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertStudio(List<StudioEntity> listStudioEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertGenre(List<GenreEntity> listGenreEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRelationTitleSynonym(
      List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRelationProducerAndAnime(
      List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRelationLicensorAndAnime(
      List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRelationStudioAndAnime(
      List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRelationGenreAndAnime(
      List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity);

  @transaction
  Future<void> insertAnimeTransaction(
      List<AnimeEntity> listAnimeEntity,
      List<StudioEntity> listStudioEntity,
      List<GenreEntity> listGenreEntity,
      List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime,
      List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity,
      List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity,
      List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity,
      List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity) async {
    await insertAnime(listAnimeEntity);
    await insertStudio(listStudioEntity);
    await insertGenre(listGenreEntity);
    await insertRelationTitleSynonym(listRelationTitleSynonymAndAnime);
    await insertRelationProducerAndAnime(listRelationProducerAndAnimeEntity);
    await insertRelationLicensorAndAnime(listRelationLicensorAndAnimeEntity);
    await insertRelationStudioAndAnime(listRelationStudioAndAnimeEntity);
    await insertRelationGenreAndAnime(listRelationGenreAndAnimeEntity);
  }

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAnimeSeasonNow(
      List<RelationSeasonNowAndAnimeEntity>
          listRelationSeasonNowAndAnimeEntity);

  @Query('DELETE FROM $tableRelationSeasonNowAndAnime')
  Future<int?> clearAnimeSeasonNow();

  @transaction
  Future<void> insertAnimeAndSeasonNowTransaction(
      List<AnimeEntity> listAnimeEntity,
      List<StudioEntity> listStudioEntity,
      List<GenreEntity> listGenreEntity,
      List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime,
      List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity,
      List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity,
      List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity,
      List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity,
      List<RelationSeasonNowAndAnimeEntity>
          listRelationSeasonNowAndAnimeEntity) async {
    await insertAnimeTransaction(
        listAnimeEntity,
        listStudioEntity,
        listGenreEntity,
        listRelationTitleSynonymAndAnime,
        listRelationProducerAndAnimeEntity,
        listRelationLicensorAndAnimeEntity,
        listRelationStudioAndAnimeEntity,
        listRelationGenreAndAnimeEntity);

    await insertAnimeSeasonNow(listRelationSeasonNowAndAnimeEntity);
  }

  @Query('SELECT * FROM $tableAnime')
  Future<List<AnimeEntity>?> getAnime();

  @Query(
      'SELECT * FROM $tableRelationTitleSynonymAndAnime WHERE $malIdAnimeRelationTitleSynonymAndAnime = :malIdAnime')
  Future<List<RelationTitleSynonymAndAnime>?> getRelationTitleSynonymAndAnime(
      int malIdAnime);

  @Query(
      'SELECT * FROM $tableRelationProducerAndAnime WHERE $malIdAnimeRelationProducerAndAnime = :malIdAnime')
  Future<List<RelationProducerAndAnimeEntity>?> getRelationProducerAndAnime(
      int malIdAnime);

  @Query('SELECT * FROM $tableStudio WHERE $malIdStudio = :malIdStudio')
  Future<StudioEntity?> getStudioFromId(int malIdStudio);

  @Query(
      'SELECT * FROM $tableRelationLicensorAndAnime WHERE $malIdAnimeRelationLicensorAndAnime = :malIdAnime')
  Future<List<RelationLicensorAndAnimeEntity>?> getRelationLicensorAndAnime(
      int malIdAnime);

  @Query(
      'SELECT * FROM $tableRelationStudioAndAnime WHERE $malIdAnimeRelationStudioAndAnime = :malIdAnime')
  Future<List<RelationStudioAndAnimeEntity>?> getRelationStudioAndAnime(
      int malIdAnime);

  @Query(
      'SELECT * FROM $tableRelationGenreAndAnime WHERE $malIdAnimeRelationGenreAndAnime = :malIdAnime')
  Future<List<RelationGenreAndAnimeEntity>?> getRelationGenreAndAnime(
      int malIdAnime);

  @Query('SELECT * FROM $tableGenre WHERE $malIdGenre = :malIdGenre')
  Future<GenreEntity?> getGenreFromId(int malIdGenre);

  @Query('DELETE FROM $tableAnime')
  Future<int?> clearAnimeRows();

  @transaction
  Future<AnimeTable> getAllAnimeEntityToAnimeTable(
      AnimeEntity animeEntity) async {
    // relation title synonym
    List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime =
        await getRelationTitleSynonymAndAnime(animeEntity.malId) ??
            <RelationTitleSynonymAndAnime>[];

    List<String> listTitleSynonym = listRelationTitleSynonymAndAnime
        .map((relationTitleSynonymAndAnime) =>
            relationTitleSynonymAndAnime.titleSynonym)
        .toList();

    // relation producer and anime
    List<StudioEntity> listProducerStudio = <StudioEntity>[];
    List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity =
        await getRelationProducerAndAnime(animeEntity.malId) ??
            <RelationProducerAndAnimeEntity>[];

    listRelationProducerAndAnimeEntity
        .forEach((relationProducerAndAnimeEntity) async {
      StudioEntity? studioEntity =
          await getStudioFromId(relationProducerAndAnimeEntity.malIdStudio);
      if (studioEntity != null) listProducerStudio.add(studioEntity);
    });

    // relation licensor and anime
    List<StudioEntity> listLicensorStudio = <StudioEntity>[];
    List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity =
        await getRelationLicensorAndAnime(animeEntity.malId) ??
            <RelationLicensorAndAnimeEntity>[];

    listRelationLicensorAndAnimeEntity
        .forEach((relationLicensorAndAnimeEntity) async {
      StudioEntity? studioEntity =
          await getStudioFromId(relationLicensorAndAnimeEntity.malIdStudio);

      if (studioEntity != null) listLicensorStudio.add(studioEntity);
    });

    // relation studio and anime
    List<StudioEntity> listStudio = <StudioEntity>[];
    List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity =
        await getRelationStudioAndAnime(animeEntity.malId) ??
            <RelationStudioAndAnimeEntity>[];

    listRelationStudioAndAnimeEntity
        .forEach((relationStudioAndAnimeEntity) async {
      StudioEntity? studioEntity =
          await getStudioFromId(relationStudioAndAnimeEntity.malIdStudio);

      if (studioEntity != null) listStudio.add(studioEntity);
    });

    // relation genre and anime
    List<GenreEntity> listGenre = <GenreEntity>[];
    List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity =
        await getRelationGenreAndAnime(animeEntity.malId) ??
            <RelationGenreAndAnimeEntity>[];

    listRelationGenreAndAnimeEntity
        .forEach((relationGenreAndAnimeEntity) async {
      GenreEntity? genreEntity =
          await getGenreFromId(relationGenreAndAnimeEntity.malIdGenre);

      if (genreEntity != null) listGenre.add(genreEntity);
    });

    AnimeTable animeTable = AnimeTable(animeEntity, listTitleSynonym,
        listProducerStudio, listLicensorStudio, listStudio, listGenre);

    return animeTable;
  }

  @transaction
  Future<List<AnimeTable>> getAnimeTable() async {
    List<AnimeTable> listAnimeTable = <AnimeTable>[];
    List<AnimeEntity> listAnimeEntity = await getAnime() ?? <AnimeEntity>[];

    await Future.forEach(listAnimeEntity, (animeEntity) async {
      AnimeTable animeTable = await getAllAnimeEntityToAnimeTable(animeEntity);

      listAnimeTable.add(animeTable);
    });

    return listAnimeTable;
  }

  @Query(
      'SELECT * FROM $tableRelationSeasonNowAndAnime LIMIT :limit OFFSET :offset')
  Future<List<RelationSeasonNowAndAnimeEntity>?> getIdAnimeSeasonNow(
      int limit, int offset);

  @Query('SELECT * FROM $tableAnime WHERE $malIdAnime = :malIdAnime')
  Future<AnimeEntity?> getAnimeFromId(int malIdAnime);

  @transaction
  Future<List<AnimeTable>> getAnimeTableSeasonNow(int limit, int offset) async {
    List<AnimeTable> listAnimeTable = <AnimeTable>[];
    List<RelationSeasonNowAndAnimeEntity> listRelationSeasonNowAndAnimeEntity =
        await getIdAnimeSeasonNow(limit, offset) ??
            <RelationSeasonNowAndAnimeEntity>[];

    await Future.forEach(listRelationSeasonNowAndAnimeEntity,
        (relationSeasonNowAndAnimeEntity) async {
      AnimeEntity? animeEntity =
          await getAnimeFromId(relationSeasonNowAndAnimeEntity.malIdAnime);

      if (animeEntity != null) {
        AnimeTable animeTable =
            await getAllAnimeEntityToAnimeTable(animeEntity);
        listAnimeTable.add(animeTable);
      }
    });

    return listAnimeTable;
  }
}
