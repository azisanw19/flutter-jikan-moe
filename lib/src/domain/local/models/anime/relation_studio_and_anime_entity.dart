import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableRelationStudioAndAnime, primaryKeys: [
  malIdAnimeRelationStudioAndAnime,
  malIdStudioRelationStudioAndAnime
], foreignKeys: [
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
  @ColumnInfo(name: malIdAnimeRelationStudioAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdStudioRelationStudioAndAnime)
  final int malIdStudio;

  const RelationStudioAndAnimeEntity(this.malIdAnime, this.malIdStudio);
}
