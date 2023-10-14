import '../../domain/remote/models/anime_response.dart';
import '../data_source/remote/anime_api_service.dart';
import 'base/base_api_repository.dart';
import '../../domain/repository/anime_repository_remote.dart';
import '../../utils/resources/data_state.dart';

class AnimeRepositoryRemoteImpl extends BaseApiRepository implements AnimeRepositoryRemote {
  final AnimeApiService _animeApiService;

  AnimeRepositoryRemoteImpl(this._animeApiService);

  /// Data source remote kirim data ke remote repository,
  /// remote repository kirim data ke local repository,
  /// local repository kirim data ke data source local,
  /// data source local kirim data ke local repository,
  /// local repository kirim data ke use case,
  /// use case kirim data ke business,
  /// business tampilin data ke ui
  @override
  Future<DataState<AnimeResponse>> getAnimeSearch() {
    Future<DataState<AnimeResponse>> futureDataStateAnimeResponse =  getStateOf<AnimeResponse>(
        request: () => _animeApiService.getAnimeSearch(),
    );

    return futureDataStateAnimeResponse;
  }

}