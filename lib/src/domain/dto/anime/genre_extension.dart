import 'package:anime_list/src/domain/local/models/anime/genre_data.dart';
import 'package:anime_list/src/domain/remote/models/other_item_response.dart';

import '../../local/entity/anime/genre_entity.dart';

extension GenreEntityExtension on GenreEntity {
  GenreData toGenreData() => GenreData(
        this.malId,
        this.type,
        this.name,
        this.url,
      );
}

extension GenreDataExtension on GenreData {
  GenreEntity toGenreEntity() => GenreEntity(
        this.malId!,
        this.type,
        this.name,
        this.url,
      );
}

extension OtherItemResponseExtension on OtherItemResponse {
  GenreData toGenreData() => GenreData(
        this.malId,
        this.type,
        this.name,
        this.url,
      );
}
