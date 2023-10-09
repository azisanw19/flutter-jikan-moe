import '../../utils/resources/data_state.dart';
import '../models/remote/anime_response.dart';

abstract class AnimeRepositoryRemote {
  Future<DataState<AnimeResponse>> getAnimeSearch();

  Future<dynamic> saveAnimeToLocalDatabase();
}