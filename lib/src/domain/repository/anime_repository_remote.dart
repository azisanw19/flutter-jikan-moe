import 'package:anime_list/src/utils/resources/data_state_pagination.dart';

import '../local/models/anime/anime_data.dart';
import '../local/models/anime/pagination_data.dart';

abstract class AnimeRepositoryRemote {
  Future<DataStatePagination<List<AnimeData>, PaginationData>> getAnimeSearch();

  Future<DataStatePagination<List<AnimeData>, PaginationData>>
      getAnimeSeasonNow(
    int page, int limit
  );
}
