import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableRelationGenreAndAnime, foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationGenreAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
  ForeignKey(
      childColumns: [malIdAnimeRelationGenreAndAnime],
      parentColumns: [malIdStudio],
      entity: StudioEntity)
])
class RelationGenreAndAnimeEntity {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: malIdRelationGenreAndAnime)
  final int? malId;

  @ColumnInfo(name: malIdAnimeRelationGenreAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdGenreRelationGenreAndAnime)
  final int malIdGenre;

  const RelationGenreAndAnimeEntity(this.malIdAnime, this.malIdGenre, {this.malId});
}
