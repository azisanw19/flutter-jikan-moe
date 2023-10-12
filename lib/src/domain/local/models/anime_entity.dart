
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableAnime, primaryKeys: [malIdAnime])
class AnimeEntity {

  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: malIdAnime)
  final String malId;

  @ColumnInfo(name: urlAnime)
  final String url;

  @ColumnInfo(name: jpgImageUrlAnime)
  final String image;

  @ColumnInfo(name: trailerYoutubeIdAnime)
  final String youtubeTrailerId;

  @ColumnInfo(name: trailerImageMediumImageUrlAnime)
  final String youtubeTrailerImage;

  @ColumnInfo(name: titleAnime)
  final String titleDefault;

  @ColumnInfo(name: titleEnglishAnime)
  final String titleEnglish;

  @ColumnInfo(name: titleJapaneseAnime)
  final String titleJapanese;

  @ColumnInfo(name: typeAnime)
  final TypeAnime type;

  @ColumnInfo(name: sourceAnime)
  final String source;


  @ColumnInfo(name: episodesAnime)
  final int episodes;

  @ColumnInfo(name: statusAnime)
  final String status;

  @ColumnInfo(name: airingAnime)
  final bool airing;

  @ColumnInfo(name: airedFromAnime)
  final String airedFrom;

  @ColumnInfo(name: airedToAnime)
  final String airedTo;

  @ColumnInfo(name: durationAnime)
  final String duration;

  @ColumnInfo(name: scoreAnime)
  final double score;

  @ColumnInfo(name: scoredByAnime)
  final int scoredBy;

  @ColumnInfo(name: rankAnime)
  final int rank;

  @ColumnInfo(name: popularityAnime)
  final int popularity;

  @ColumnInfo(name: favoritesAnime)
  final int favorite;

  @ColumnInfo(name: synopsisAnime)
  final String synopsis;

  @ColumnInfo(name: backgroundAnime)
  final String background;

  @ColumnInfo(name: seasonAnime)
  final String season;

  @ColumnInfo(name: broadcastDayAnime)
  final String broadcastDay;

  @ColumnInfo(name: broadcastTimeAnime)
  final String broadcastTime;

  @ColumnInfo(name: broadcastTimezoneAnime)
  final String broadcastTimezone;


  AnimeEntity(this.malId, this.url, this.image, this.youtubeTrailerId, this.youtubeTrailerImage, this.titleDefault, this.titleEnglish, this.titleJapanese, this.type, this.source, this.episodes, this.status, this.airing, this.airedFrom, this.airedTo, this.duration, this.score, this.scoredBy, this.rank, this.popularity, this.favorite, this.synopsis, this.background, this.season, this.broadcastDay, this.broadcastTime, this.broadcastTimezone);


}


// "tv" "movie" "ova" "special" "ona" "music"
enum TypeAnime{
  tv('tv'),
  movie('movie'),
  ova('ova'),
  special('special'),
  ona('ona'),
  music('music');

  final String name;

  const TypeAnime(this.name);
}