import '../../domain/local/models/anime/anime_data.dart';

sealed class StateDetailAnime {}

class StateDetailAnimeLoading extends StateDetailAnime {
  StateDetailAnimeLoading();
}

class StateDetailAnimeError extends StateDetailAnime {
  StateDetailAnimeError();
}

class StateDetailAnimeData extends StateDetailAnime {
  final AnimeData data;
  StateDetailAnimeData(this.data);
}