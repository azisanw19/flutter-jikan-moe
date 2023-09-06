import 'package:anime_list/src/domain/models/response/PaginationResponse.dart';

class AnimeResponse {
  AnimeResponse({
    this.pagination
  });

  AnimeResponse.fromJson(dynamic json) {
    pagination = json['pagination'];
  }

  PaginationResponse? pagination;

  AnimeResponse copyWith({
    PaginationResponse? pagination,
  }) =>
      AnimeResponse(
        pagination: pagination ?? this.pagination,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pagination'] = pagination;
    return map;
  }
}
