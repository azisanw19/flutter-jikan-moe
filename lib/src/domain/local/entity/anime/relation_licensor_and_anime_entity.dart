import 'package:anime_list/src/domain/local/entity/anime/studio_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

import 'anime_entity.dart';

@Entity(tableName: tableRelationLicensorAndAnime, primaryKeys: [
  malIdAnimeRelationLicensorAndAnime,
  malIdStudioRelationLicensorAndAnime
], foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationLicensorAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
  ForeignKey(
      childColumns: [malIdStudioRelationLicensorAndAnime],
      parentColumns: [malIdStudio],
      entity: StudioEntity)
])
class RelationLicensorAndAnimeEntity {
  @ColumnInfo(name: malIdAnimeRelationLicensorAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdStudioRelationLicensorAndAnime)
  final int malIdStudio;

  const RelationLicensorAndAnimeEntity(this.malIdAnime, this.malIdStudio);
}
