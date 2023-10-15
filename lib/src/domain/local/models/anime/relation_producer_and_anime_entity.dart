import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableRelationProducerAndAnime, foreignKeys: [
  ForeignKey(
      childColumns: [malIdAnimeRelationProducerAndAnime],
      parentColumns: [malIdAnime],
      entity: AnimeEntity),
  ForeignKey(
      childColumns: [malIdStudioRelationProducerAndAnime],
      parentColumns: [malIdStudio],
      entity: StudioEntity)
])
class RelationProducerAndAnimeEntity {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: malIdRelationProducerAndAnime)
  final int? malId;

  @ColumnInfo(name: malIdAnimeRelationProducerAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdStudioRelationProducerAndAnime)
  final int malIdStudio;

  const RelationProducerAndAnimeEntity(this.malIdAnime, this.malIdStudio, {this.malId});
}
