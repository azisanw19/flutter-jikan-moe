import 'pagination_response.dart';
import 'data_anime_response.dart';

class AnimeResponse {
  AnimeResponse({
    this.pagination,
    this.dataAnimeResponses,
  });

  AnimeResponse.fromJson(Map<String, dynamic> json) {
    pagination = PaginationResponse.fromJson(json['pagination']);
    dataAnimeResponses = json['data'].cast<DataAnimeResponse>();
  }

  PaginationResponse? pagination;
  List<DataAnimeResponse?>? dataAnimeResponses;

  AnimeResponse copyWith({
    PaginationResponse? pagination,
    List<DataAnimeResponse?>? dataAnimeResponses,
  }) =>
      AnimeResponse(
        pagination: pagination ?? this.pagination,
        dataAnimeResponses: dataAnimeResponses ?? this.dataAnimeResponses,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pagination'] = pagination;
    map['data'] = dataAnimeResponses?.map((element) => element?.toJson());
    return map;
  }
}
