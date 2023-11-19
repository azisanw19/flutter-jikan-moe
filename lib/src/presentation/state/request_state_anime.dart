sealed class RequestStateAnime {}

class RequestStateGetAnime extends RequestStateAnime {}

class RequestStateGetAnimeSeasonNow extends RequestStateAnime {
  final int page;

  RequestStateGetAnimeSeasonNow(this.page);
}