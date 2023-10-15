import 'package:floor/floor.dart';

import '../../../../domain/local/models/anime/anime_entity.dart';
import '../../../../utils/constants/table_database_anime.dart';

@dao // data access object
abstract class AnimeDao {

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<int> insertAnime(List<AnimeEntity> animeEntities); // return id

  @Update()
  Future<int> updateAnime(List<AnimeEntity> animeEntities); // return number of edited row

  @Query('DELETE FROM $tableAnime')
  Future<int> clearAnimeRows();

  @Query('SELECT * FROM $tableAnime')
  Stream<List<AnimeEntity>> getAnime();


}