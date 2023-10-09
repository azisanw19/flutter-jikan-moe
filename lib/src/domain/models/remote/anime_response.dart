import 'pagination_response.dart';
import 'data_anime_response.dart';

class AnimeResponse {
  AnimeResponse({
    this.pagination,
    this.dataAnimeResponse,
  });

  AnimeResponse.fromJson(Map<String, dynamic> json) {
    pagination = PaginationResponse.fromJson(json['pagination']);
    // dataAnimeResponse = json['data'] as DataAnimeResponse;
  }

  PaginationResponse? pagination;
  DataAnimeResponse? dataAnimeResponse;

  AnimeResponse copyWith({
    PaginationResponse? pagination,
    DataAnimeResponse? dataAnimeResponse,
  }) =>
      AnimeResponse(
        pagination: pagination ?? this.pagination,
        dataAnimeResponse: dataAnimeResponse ?? this.dataAnimeResponse,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pagination'] = pagination;
    map['data'] = dataAnimeResponse;
    return map;
  }
}
