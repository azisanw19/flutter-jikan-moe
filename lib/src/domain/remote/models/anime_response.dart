import 'package:anime_list/src/domain/remote/models/pagination_response.dart';

import 'data_anime_response.dart';

class AnimeResponse {
  AnimeResponse({
    this.pagination,
    this.dataAnimeResponses,
  });

  AnimeResponse.fromJson(Map<String, dynamic> json) {
    pagination = PaginationResponse.fromJson(json['pagination']);
    dataAnimeResponses = List<dynamic>.from(json['data']).map((animeResponse) => DataAnimeResponse.fromJson(animeResponse)).toList();
    print(dataAnimeResponses);
  }

  PaginationResponse? pagination;
  List<DataAnimeResponse>? dataAnimeResponses;

  AnimeResponse copyWith({
    PaginationResponse? pagination,
    List<DataAnimeResponse>? dataAnimeResponses,
  }) =>
      AnimeResponse(
        pagination: pagination ?? this.pagination,
        dataAnimeResponses: dataAnimeResponses ?? this.dataAnimeResponses,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pagination'] = pagination;
    map['data'] = dataAnimeResponses?.map((element) => element.toJson());
    return map;
  }
}
