import 'package:anime_list/src/domain/dto/anime/genre_extension.dart';
import 'package:anime_list/src/domain/dto/anime/studio_extension.dart';
import 'package:anime_list/src/domain/remote/models/data_anime_response.dart';

import '../../../utils/converter/type_anime_converter.dart';
import '../../local/entity/anime/anime_entity.dart';
import '../../local/entity/anime/anime_table.dart';
import '../../local/models/anime/anime_data.dart';
import '../../local/models/anime/genre_data.dart';

extension AnimeDataExtension on AnimeData {
  AnimeEntity toAnimeEntity() => AnimeEntity(
        this.malId!,
        this.url,
        this.image,
        this.youtubeTrailerId,
        this.youtubeTrailerImage,
        this.titleDefault,
        this.titleEnglish,
        this.titleJapanese,
        this.type,
        this.source,
        this.episodes,
        this.status,
        this.airing,
        this.airedFrom,
        this.airedTo,
        this.duration,
        this.rating,
        this.score,
        this.scoredBy,
        this.rank,
        this.popularity,
        this.favorite,
        this.synopsis,
        this.background,
        this.season,
        this.broadcastDay,
        this.broadcastTime,
        this.broadcastTimezone,
      );
}

extension AnimeTableExtention on AnimeTable {
  AnimeData toAnimeData() {
    return AnimeData(
      this.animeEntity.malId,
      this.animeEntity.url,
      this.animeEntity.image,
      this.animeEntity.youtubeTrailerId,
      this.animeEntity.youtubeTrailerImage,
      this.animeEntity.titleDefault,
      this.animeEntity.titleEnglish,
      this.animeEntity.titleJapanese,
      this.listTitleSynonym,
      this.animeEntity.type,
      this.animeEntity.source,
      this.animeEntity.episodes,
      this.animeEntity.status,
      this.animeEntity.airing,
      this.animeEntity.airedFrom,
      this.animeEntity.airedTo,
      this.animeEntity.duration,
      this.animeEntity.rating,
      this.animeEntity.score,
      this.animeEntity.scoredBy,
      this.animeEntity.rank,
      this.animeEntity.popularity,
      this.animeEntity.favorite,
      this.animeEntity.synopsis,
      this.animeEntity.background,
      this.animeEntity.season,
      this.animeEntity.broadcastDay,
      this.animeEntity.broadcastTime,
      this.animeEntity.broadcastTimezone,
      this.listProducerStudio
          .map((studioEntity) => studioEntity.toStudioData())
          .toList(),
      this.listLicensorStudio
          .map((studioEntity) => studioEntity.toStudioData())
          .toList(),
      this.listStudio
          .map((studioEntity) => studioEntity.toStudioData())
          .toList(),
      this.listGenre
          .map((genreEntity) => genreEntity.toGenreData())
          .toList(),
    );
  }
}

extension DataAnimeResponseExtension on DataAnimeResponse {
  AnimeData toAnimeData() => AnimeData(
  this.malId,
  this.url,
  this.images?.jpg?.imageUrl,
  this.trailer?.youtubeId,
  this.trailer?.images?.imageUrl,
  this.title,
  this.titleEnglish,
  this.titleJapanese,
  this.titleSynonyms,
  this.type != null
  ? TypeAnimeConverter().encode(this.type!)
      : null,
  this.source,
  this.episodes,
  this.status,
  this.airing,
  '${this.aired?.prop?.from?.day}-${this.aired?.prop?.from?.month}-${this.aired?.prop?.from?.year}',
  '${this.aired?.prop?.to?.day}-${this.aired?.prop?.to?.month}-${this.aired?.prop?.to?.year}',
  this.duration,
  this.rating,
  this.score,
  this.scoredBy,
  this.rank,
  this.popularity,
  this.favorites,
  this.synopsis,
  this.background,
  this.season,
  this.broadcast?.day,
  this.broadcast?.time,
  this.broadcast?.timezone,
  this.producers
      ?.map((otherItemResponse) =>
  otherItemResponse.toStudioData())
      .toList(),
  this.licensors
      ?.map((otherItemResponse) =>
  otherItemResponse.toStudioData())
      .toList(),
  this.studios
      ?.map((otherItemResponse) =>
  otherItemResponse.toStudioData())
      .toList(),
  <GenreData>[
  ...?this.genres
      ?.map((otherItemResponse) =>
  otherItemResponse.toGenreData())
      .toList(),
  ...?this.themes
      ?.map((otherItemResponse) =>
  otherItemResponse.toGenreData())
      .toList(),
  ...?this.demographics
      ?.map((otherItemResponse) =>
  otherItemResponse.toGenreData())
      .toList()
  ]);
}