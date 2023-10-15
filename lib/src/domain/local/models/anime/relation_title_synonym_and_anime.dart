import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableRelationTitleSynonymAndAnime, foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationTitleSynonymAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
])
class RelationTitleSynonymAndAnime {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: malIdRelationTitleSynonymAndAnime)
  final int? malId;

  @ColumnInfo(name: malIdAnimeRelationTitleSynonymAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: titleSynonymRelationTitleSynonymAndAnime)
  final String malIdStudio;

  const RelationTitleSynonymAndAnime(this.malIdAnime, this.malIdStudio, {this.malId});
}
