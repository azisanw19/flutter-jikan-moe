import 'package:anime_list/src/domain/remote/models/other_item_response.dart';
import 'package:anime_list/src/domain/remote/models/title_item_response.dart';
import 'package:anime_list/src/domain/remote/models/trailer_response.dart';

import 'aired_responses.dart';
import 'broadcast_response.dart';
import 'image_response.dart';

class DataAnimeResponse {
  DataAnimeResponse({
    this.malId,
    this.url,
    this.images,
    this.trailer,
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
    this.producers,
    this.licensors,
    this.studios,
    this.genres,
    this.themes,
    this.demographics,
  });

  DataAnimeResponse.fromJson
      (dynamic json) {
    malId = json['mal_id'];
    url = json['url'];
    images = ImageResponse.fromJson(json['images']);
    trailer = TrailerResponse.fromJson(json['trailer']);
    approved = json['approved'];
    titles = List<dynamic>.from(json['titles']).map((titleItemResponse) => TitleItemResponse.fromJson(titleItemResponse)).toList();
    title = json['title'];
    titleEnglish = json['title_english'];
    titleJapanese = json['title_japanese'];
    titleSynonyms = List<dynamic>.from(json['title_synonyms']).map((titleSynonym) => titleSynonym.toString()).toList();
    type = json['type'];
    source = json['source'];
    episodes = json['episodes'];
    status = json['status'];
    airing = json['airing'];
    aired = AiredResponse.fromJson(json['aired']);
    duration = json['duration'];
    rating = json['rating'];
    score = json['score'].toDouble();
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
    producers = List<dynamic>.from(json['producers']).map((producer) => OtherItemResponse.fromJson(producer)).toList();
    licensors = List<dynamic>.from(json['licensors']).map((licensor) => OtherItemResponse.fromJson(licensor)).toList();
    studios = List<dynamic>.from(json['studios']).map((studio) => OtherItemResponse.fromJson(studio)).toList();
    genres = List<dynamic>.from(json['genres']).map((genre) => OtherItemResponse.fromJson(genre)).toList();
    themes = List<dynamic>.from(json['themes']).map((theme) => OtherItemResponse.fromJson(theme)).toList();
    demographics = List<dynamic>.from(json['demographics']).map((demographic) => OtherItemResponse.fromJson(demographic)).toList();
  }

  int? malId;
  String? url;
  ImageResponse? images;
  TrailerResponse? trailer;
  bool? approved;
  List<TitleItemResponse>? titles;
  String? title;
  String? titleEnglish;
  String? titleJapanese;
  List<String>? titleSynonyms;
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
  List<OtherItemResponse>? producers;
  List<OtherItemResponse>? licensors;
  List<OtherItemResponse>? studios;
  List<OtherItemResponse>? genres;
  List<OtherItemResponse>? themes;
  List<OtherItemResponse>? demographics;


  DataAnimeResponse copyWith({
    int? malId,
    String? url,
    ImageResponse? images,
    TrailerResponse? trailer,
    bool? approved,
    List<TitleItemResponse>? titles,
    String? title,
    String? titleEnglish,
    String? titleJapanese,
    List<String>? titleSynonyms,
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
    List<OtherItemResponse>? producers,
    List<OtherItemResponse>? licensors,
    List<OtherItemResponse>? studios,
    List<OtherItemResponse>? genres,
    List<OtherItemResponse>? themes,
    List<OtherItemResponse>? demographics,
  }) =>
      DataAnimeResponse(
        malId: malId ?? this.malId,
        url: url ?? this.url,
        images: images ?? this.images,
        trailer: trailer ?? this.trailer,
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
        producers: producers ?? this.producers,
        licensors: licensors ?? this.licensors,
        studios: studios ?? this.studios,
        genres: genres ?? this.genres,
        themes: themes ?? this.themes,
        demographics: demographics ?? this.demographics,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mal_id'] = malId;
    map['url'] = url;
    map['images'] = images;
    map['trailer'] = trailer;
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
    map['producers'] = producers;
    map['licensors'] = licensors;
    map['studios'] = studios;
    map['genres'] = genres;
    map['themes'] = themes;
    map['demographics'] = demographics;
    return map;
  }
}