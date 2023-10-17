import 'package:anime_list/src/domain/local/models/anime/relation_genre_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_licensor_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_studio_and_anime_entity.dart';
import 'package:floor/floor.dart';

import '../../../../domain/local/models/anime/anime_entity.dart';
import '../../../../domain/local/models/anime/genre_entity.dart';
import '../../../../domain/local/models/anime/relation_producer_and_anime_entity.dart';
import '../../../../domain/local/models/anime/relation_title_synonym_and_anime.dart';
import '../../../../domain/local/models/anime/studio_entity.dart';
import '../../../../utils/constants/table_database_anime.dart';

@dao // data access object
abstract class AnimeDao {
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<int> insertAnime(List<AnimeEntity> listAnimeEntity); // return id

  @Insert()
  Future<int> insertStudio(List<StudioEntity> listStudioEntity);

  @Insert()
  Future<int> insertGenre(List<GenreEntity> listGenreEntity);

  @Insert()
  Future<int> insertRelationTitleSynonym(
      List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime);

  @Insert()
  Future<int> insertRelationProducerAndAnime(
      List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity);

  @Insert()
  Future<int> insertRelationLicensorAndAnime(
      List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity);

  @Insert()
  Future<int> insertRelationStudioAndAnime(
      List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity);

  @Insert()
  Future<int> insertRelationGenreAndAnime(
      List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity);

  @Query('SELECT * FROM $tableAnime')
  Stream<List<AnimeEntity>?> getAnime();

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
  Future<GenreEntity?> getGenreFromId(int malIdStudio);

  @Query('DELETE FROM $tableAnime')
  Future<int> clearAnimeRows();
}
