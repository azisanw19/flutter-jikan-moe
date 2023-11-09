import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';

sealed class ResponseStateHome {}

class ResponseStateLoading extends ResponseStateHome {
  ResponseStateLoading();
}

class ResponseStateError extends ResponseStateHome {
  ResponseStateError();
}

class ResponseStateGetAnime extends ResponseStateHome {
  final List<AnimeData> data;
  ResponseStateGetAnime(this.data);
}

class ResponseStateGetAnimeSeasonNow extends ResponseStateHome {
  final List<AnimeData> data;
  ResponseStateGetAnimeSeasonNow(this.data);
}