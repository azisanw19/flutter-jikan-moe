import 'package:anime_list/src/domain/data_transfer_object/studio_data.dart';

import '../../utils/constants/type_anime.dart';
import 'genre_data.dart';

class AnimeData {
  final int? malId;

  final String? url;

  final String? image;

  final String? youtubeTrailerId;

  final String? youtubeTrailerImage;

  final String? titleDefault;

  final String? titleEnglish;

  final String? titleJapanese;

  final List<String>? titleSynonyms;

  final TypeAnime? type;

  final String? source;

  final int? episodes;

  final String? status;

  final bool? airing;

  final String? airedFrom;

  final String? airedTo;

  final String? duration;

  final String? rating;

  final double? score;

  final int? scoredBy;

  final int? rank;

  final int? popularity;

  final int? favorite;

  final String? synopsis;

  final String? background;

  final String? season;

  final String? broadcastDay;

  final String? broadcastTime;

  final String? broadcastTimezone;

  final List<StudioData>? producers;

  final List<StudioData>? licensors;

  final List<StudioData>? studios;

  final List<GenreData>? genres;

  AnimeData(
    this.malId,
    this.url,
    this.image,
    this.youtubeTrailerId,
    this.youtubeTrailerImage,
    this.titleDefault,
    this.titleEnglish,
    this.titleJapanese,
    this.titleSynonyms,
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
    this.producers,
    this.licensors,
    this.studios,
    this.genres,
  );
}
