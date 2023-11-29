sealed class RequestStateDetailAnime {}

class RequestStateGetDetailAnime extends RequestStateDetailAnime {
  final int malId;

  RequestStateGetDetailAnime(this.malId);
}