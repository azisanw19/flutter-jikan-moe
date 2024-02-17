import '../../domain/local/models/anime/anime_data.dart';

sealed class StateAnime {}

class StateAnimeLoading extends StateAnime {
  StateAnimeLoading();
}

class StateAnimeError extends StateAnime {
  StateAnimeError();
}

class StateAnimeData extends StateAnime {
  final List<AnimeData> data;
  StateAnimeData(this.data);
}

class StateAnimeDataSeasonNow extends StateAnime {
  final List<AnimeData> data;
  StateAnimeDataSeasonNow(this.data);
}

class StateDetailAnimeData extends StateAnime {
  final AnimeData data;
  StateDetailAnimeData(this.data);
}