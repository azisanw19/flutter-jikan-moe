import 'package:floor/floor.dart';

import '../../../../domain/local/models/anime/anime_entity.dart';
import '../../../../domain/local/models/anime/studio_entity.dart';
import '../../../../utils/constants/table_database_anime.dart';

@dao // data access object
abstract class AnimeDao {

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<int> insertAnime(List<AnimeEntity> listAnimeEntity); // return id

  @Update()
  Future<int> updateAnime(List<AnimeEntity> listAnimeEntity); // return number of edited row

  @Query('DELETE FROM $tableAnime')
  Future<int> clearAnimeRows();

  @Query('SELECT * FROM $tableAnime')
  Stream<List<AnimeEntity>> getAnime();

  @Insert()
  Future<int> insertStudio(List<StudioEntity> listStudioEntity);


}