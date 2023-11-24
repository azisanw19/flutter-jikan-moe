import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

import 'anime_entity.dart';

@Entity(tableName: tableRelationSeasonNowAndAnime, primaryKeys: [malIdRelationSeasonNowAndAnime], foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationSeasonNowAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
])
class RelationSeasonNowAndAnimeEntity {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: malIdRelationSeasonNowAndAnime)
  int? malId;
  @ColumnInfo(name: malIdAnimeRelationSeasonNowAndAnime)
  final int malIdAnime;

  RelationSeasonNowAndAnimeEntity(this.malIdAnime);
}