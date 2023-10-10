import 'package:anime_list/src/domain/remote/models/title_item_response.dart';

import 'aired_responses.dart';
import 'broadcast_response.dart';
import 'image_response.dart';

class DataAnimeResponse {
  DataAnimeResponse({
    this.malId,
    this.url,
    this.images,
    this.approved,
    this.titles,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.titleSynonyms,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.broadcast,
  });

  DataAnimeResponse.fromJson
      (dynamic json) {
    malId = json['mal_id'];
    url = json['url'];
    images = ImageResponse.fromJson(json['images']);
    approved = json['approved'];
    titles =
        json['titles'].map((element) => TitleItemResponse.fromJson(element));
    title = json['title'];
    titleEnglish = json['title_english'];
    titleJapanese = json['title_japanese'];
    titleSynonyms = json['title_synonyms'];
    type = json['type'];
    source = json['source'];
    episodes = json['episodes'];
    status = json['status'];
    airing = json['airing'];
    aired = AiredResponse.fromJson(json['aired']);
    duration = json['duration'];
    rating = json['rating'];
    score = json['score'];
    scoredBy = json['scored_by'];
    rank = json['rank'];
    popularity = json['popularity'];
    members = json['members'];
    favorites = json['favorites'];
    synopsis = json['synopsis'];
    background = json['background'];
    season = json['season'];
    year = json['year'];
    broadcast = BroadcastResponse.fromJson(json['broadcast']);
  }

  int? malId;
  String? url;
  ImageResponse? images;
  bool? approved;
  List<TitleItemResponse?>? titles;
  String? title;
  String? titleEnglish;
  String? titleJapanese;
  dynamic? titleSynonyms;
  String? type;
  String? source;
  int? episodes;
  String? status;
  bool? airing;
  AiredResponse? aired;
  String? duration;
  String? rating;
  double? score;
  int? scoredBy;
  int? rank;
  int? popularity;
  int? members;
  int? favorites;
  String? synopsis;
  String? background;
  String? season;
  int? year;
  BroadcastResponse? broadcast;

  DataAnimeResponse copyWith({
    int? malId,
    String? url,
    ImageResponse? images,
    bool? approved,
    List<TitleItemResponse?>? titles,
    String? title,
    String? titleEnglish,
    String? titleJapanese,
    dynamic? titleSynonyms,
    String? type,
    String? source,
    int? episodes,
    String? status,
    bool? airing,
    AiredResponse? aired,
    String? duration,
    String? rating,
    double? score,
    int? scoredBy,
    int? rank,
    int? popularity,
    int? members,
    int? favorites,
    String? synopsis,
    String? background,
    String? season,
    int? year,
    BroadcastResponse? broadcast,
  }) =>
      DataAnimeResponse(
        malId: malId ?? this.malId,
        url: url ?? this.url,
        images: images ?? this.images,
        approved: approved ?? this.approved,
        titles: titles ?? this.titles,
        title: title ?? this.title,
        titleEnglish: titleEnglish ?? this.titleEnglish,
        titleJapanese: titleJapanese ?? this.titleJapanese,
        titleSynonyms: titleSynonyms ?? this.titleSynonyms,
        type: type ?? this.type,
        source: source ?? this.source,
        episodes: episodes ?? this.episodes,
        status: status ?? this.status,
        airing: airing ?? this.airing,
        aired: aired ?? this.aired,
        duration: duration ?? this.duration,
        rating: rating ?? this.rating,
        score: score ?? this.score,
        scoredBy: scoredBy ?? this.scoredBy,
        rank: rank ?? this.rank,
        popularity: popularity ?? this.popularity,
        members: members ?? this.members,
        favorites: favorites ?? this.favorites,
        synopsis: synopsis ?? this.synopsis,
        background: background ?? this.background,
        season: season ?? this.season,
        year: year ?? this.year,
        broadcast: broadcast ?? this.broadcast,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mal_id'] = malId;
    map['url'] = url;
    map['images'] = images;
    map['approved'] = approved;
    map['titles'] = titles;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_japanese'] = titleJapanese;
    map['title_synonyms'] = titleSynonyms;
    map['type'] = type;
    map['source'] = source;
    map['episodes'] = episodes;
    map['status'] = status;
    map['airing'] = airing;
    map['aired'] = aired?.toJson();
    map['duration'] = duration;
    map['rating'] = rating;
    map['score'] = score;
    map['scored_by'] = scoredBy;
    map['rank'] = rank;
    map['popularity'] = popularity;
    map['members'] = members;
    map['favorites'] = favorites;
    map['synopsis'] = synopsis;
    map['background'] = background;
    map['season'] = season;
    map['year'] = year;
    map['broadcast'] = broadcast;
    return map;
  }
}