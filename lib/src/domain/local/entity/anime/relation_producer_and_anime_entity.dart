import 'package:anime_list/src/domain/local/entity/anime/studio_entity.dart';
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

import 'anime_entity.dart';

@Entity(tableName: tableRelationProducerAndAnime, primaryKeys: [
  malIdAnimeRelationProducerAndAnime,
  malIdStudioRelationProducerAndAnime
], foreignKeys: [
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
  @ColumnInfo(name: malIdAnimeRelationProducerAndAnime)
  final int malIdAnime;

  @ColumnInfo(name: malIdStudioRelationProducerAndAnime)
  final int malIdStudio;

  const RelationProducerAndAnimeEntity(this.malIdAnime, this.malIdStudio);
}
