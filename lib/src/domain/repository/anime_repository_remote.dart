import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/domain/data_transfer_object/pagination_data.dart';
import 'package:anime_list/src/utils/resources/data_state_pagination.dart';


abstract class AnimeRepositoryRemote {
  Future<DataStatePagination<List<AnimeData>, PaginationData>> getAnimeSearch();


}