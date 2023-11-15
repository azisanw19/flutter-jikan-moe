import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';

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