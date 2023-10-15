import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableRelationStudioAndAnime, foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationStudioAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
  ForeignKey(
      childColumns: [malIdStudioRelationStudioAndAnime],
      parentColumns: [malIdStudio],
      entity: StudioEntity)
])
class RelationStudioAndAnimeEntity {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: malIdRelationStudioAndAnime)
  final int? malId;

  @ColumnInfo(name: malIdAnimeRelationStudioAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdStudioRelationStudioAndAnime)
  final int malIdStudio;

  const RelationStudioAndAnimeEntity(this.malIdAnime, this.malIdStudio, {this.malId});
}
