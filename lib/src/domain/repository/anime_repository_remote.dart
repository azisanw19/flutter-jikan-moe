import '../../utils/resources/data_state.dart';
import '../remote/models/anime_response.dart';

abstract class AnimeRepositoryRemote {
  Future<DataState<AnimeResponse>> getAnimeSearch();


}