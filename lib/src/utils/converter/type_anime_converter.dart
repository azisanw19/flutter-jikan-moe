import 'package:anime_list/src/utils/constants/type_anime.dart';
import 'package:anime_list/src/utils/converter/base/enum_converter.dart';

class TypeAnimeConverter implements EnumConverter<TypeAnime, String> {

  @override
  String decode(TypeAnime from) {
    return from.name;
  }

  // "tv" "movie" "ova" "special" "ona" "music" "other"
  @override
  TypeAnime encode(String from) {
    if (from.toLowerCase().trim() == TypeAnime.tv.name.toLowerCase().trim()) {
      return TypeAnime.tv;
    }
    else if (from.toLowerCase().trim() == TypeAnime.movie.name.toLowerCase().trim()) {
      return TypeAnime.movie;
    }
    else if (from.toLowerCase().trim() == TypeAnime.ova.name.toLowerCase().trim()) {
      return TypeAnime.ova;
    }
    else if (from.toLowerCase().trim() == TypeAnime.special.name.toLowerCase().trim()) {
      return TypeAnime.special;
    }
    else if (from.toLowerCase().trim() == TypeAnime.ona.name.toLowerCase().trim()) {
      return TypeAnime.ona;
    }
    else if (from.toLowerCase().trim() == TypeAnime.music.name.toLowerCase().trim()) {
      return TypeAnime.music;
    }
    else {
      return TypeAnime.other;
    }
  }
}
