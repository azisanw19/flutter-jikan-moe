import '../remote/anime_api_service.dart';
import 'base/base_api_repository.dart';
import '../../domain/models/response/anime_response.dart';
import '../../domain/repository/anime_repository.dart';
import '../../utils/resources/data_state.dart';

class AnimeRepositoryImpl extends BaseApiRepository implements AnimeRepository {
  final AnimeApiService _animeApiService;

  AnimeRepositoryImpl(this._animeApiService);

  @override
  Future<DataState<AnimeResponse>> getAnimeSearch() {
    return getStateOf<AnimeResponse>(
        request: () => _animeApiService.getAnimeSearch(),
    );
  }

}