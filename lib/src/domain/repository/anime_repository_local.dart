import 'package:anime_list/src/utils/resources/data_state.dart';

import '../local/models/anime/anime_entity.dart';

abstract class AnimeRepositoryLocal {

  Future<DataState<int>> insertAnime(List<AnimeEntity> animeEntities);
  Future<DataState<int>> clearAnimeRows();

}