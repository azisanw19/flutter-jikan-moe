import '../../domain/local/models/anime/anime_data.dart';

sealed class ResponseStateDetailAnime {}

class ResponseStateLoading extends ResponseStateDetailAnime {
  ResponseStateLoading();
}

class ResponseStateError extends ResponseStateDetailAnime {
  ResponseStateError();
}

class ResponseStateGetDetailAnime extends ResponseStateDetailAnime {
  final AnimeData data;
  ResponseStateGetDetailAnime(this.data);
}