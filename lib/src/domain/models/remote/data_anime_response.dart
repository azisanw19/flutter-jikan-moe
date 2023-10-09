class DataAnimeResponse {
  DataAnimeResponse({
    this.malId,
    this.url,
  });

  DataAnimeResponse.fromJson
      (dynamic json) {
    malId = json['mal_id'];
    url = json['url'];
  }

  int? malId;
  String? url;

  DataAnimeResponse copyWith({
    int? malId,
    String? url,
  }) =>
      DataAnimeResponse(
        malId: malId ?? this.malId,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mal_id'] = malId;
    map['url'] = url;
    return map;
  }
}