import 'package:anime_list/src/domain/local/entity/anime/studio_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_data.dart';
import 'package:anime_list/src/domain/remote/models/other_item_response.dart';

extension StudioEntityExtension on StudioEntity {
  StudioData toStudioData() => StudioData(
        this.malId,
        this.type,
        this.name,
        this.url,
      );
}

extension StudioDataExtension on StudioData {
  StudioEntity toStudioEntity() => StudioEntity(
        this.malId!,
        this.type,
        this.name,
        this.url,
      );
}

extension OtherItemExtension on OtherItemResponse {
  StudioData toStudioData() => StudioData(
        this.malId,
        this.type,
        this.name,
        this.url,
      );
}
