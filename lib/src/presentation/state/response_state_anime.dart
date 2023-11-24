import '../../domain/local/models/anime/anime_data.dart';

sealed class ResponseStateAnime {}

class ResponseStateLoading extends ResponseStateAnime {
  ResponseStateLoading();
}

class ResponseStateError extends ResponseStateAnime {
  ResponseStateError();
}

class ResponseStateGetAnime extends ResponseStateAnime {
  final List<AnimeData> data;
  ResponseStateGetAnime(this.data);
}

class ResponseStateGetAnimeSeasonNow extends ResponseStateAnime {
  final List<AnimeData> data;
  ResponseStateGetAnimeSeasonNow(this.data);
}