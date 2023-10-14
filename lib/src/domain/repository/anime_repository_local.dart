import '../local/models/anime_entity.dart';

abstract class AnimeRepositoryLocal {

  Future<int> insertAnime(List<AnimeEntity> animeEntities);
  Future<int> clearAnimeRows();

}