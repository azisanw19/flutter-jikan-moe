import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableRelationTitleSynonymAndAnime, primaryKeys: [
  malIdAnimeRelationTitleSynonymAndAnime,
  titleSynonymRelationTitleSynonymAndAnime
], foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationTitleSynonymAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
])
class RelationTitleSynonymAndAnime {
  @ColumnInfo(name: malIdAnimeRelationTitleSynonymAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: titleSynonymRelationTitleSynonymAndAnime)
  final String titleSynonym;

  const RelationTitleSynonymAndAnime(this.malIdAnime, this.titleSynonym);
}
