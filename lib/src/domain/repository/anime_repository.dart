import '../models/response/anime_response.dart';

import '../../utils/resources/data_state.dart';

abstract class AnimeRepository {
  Future<DataState<AnimeResponse>> getAnimeSearch();
}