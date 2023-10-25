import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/studio_entity.dart';

import 'genre_entity.dart';

class AnimeTable {
  final AnimeEntity animeEntity;
  final List<String> listTitleSynonym;
  final List<StudioEntity> listProducerStudio;
  final List<StudioEntity> listLicensorStudio;
  final List<StudioEntity> listStudio;
  final List<GenreEntity> listGenre;

  const AnimeTable(
      this.animeEntity,
      this.listTitleSynonym,
      this.listProducerStudio,
      this.listLicensorStudio,
      this.listStudio,
      this.listGenre);
}
