import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

import 'anime_entity.dart';
import 'genre_entity.dart';

@Entity(tableName: tableRelationGenreAndAnime, primaryKeys: [
  malIdAnimeRelationGenreAndAnime,
  malIdGenreRelationGenreAndAnime
], foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationGenreAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
  ForeignKey(
      childColumns: [malIdGenreRelationGenreAndAnime],
      parentColumns: [malIdGenre],
      entity: GenreEntity)
])
class RelationGenreAndAnimeEntity {
  @ColumnInfo(name: malIdAnimeRelationGenreAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdGenreRelationGenreAndAnime)
  final int malIdGenre;

  const RelationGenreAndAnimeEntity(this.malIdAnime, this.malIdGenre);
}
