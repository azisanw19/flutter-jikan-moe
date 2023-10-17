import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableRelationLicensorAndAnime, foreignKeys: [
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

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: malIdRelationLicensorAndAnime)
  final int? malId;

  @ColumnInfo(name: malIdAnimeRelationLicensorAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdStudioRelationLicensorAndAnime)
  final int malIdStudio;

  const RelationLicensorAndAnimeEntity(this.malIdAnime, this.malIdStudio, {this.malId});
}
