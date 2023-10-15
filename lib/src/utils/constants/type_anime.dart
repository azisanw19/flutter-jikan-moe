// "tv" "movie" "ova" "special" "ona" "music"
enum TypeAnime{
  tv('tv'),
  movie('movie'),
  ova('ova'),
  special('special'),
  ona('ona'),
  music('music'),
  other('other');

  final String name;

  const TypeAnime(this.name);
}