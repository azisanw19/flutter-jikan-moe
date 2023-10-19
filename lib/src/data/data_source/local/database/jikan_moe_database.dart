import 'dart:async';

import 'package:anime_list/src/data/data_source/local/dao/anime_dao.dart';
import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/genre_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_licensor_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_studio_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/anime/relation_title_synonym_and_anime.dart';
import 'package:floor/floor.dart';

// ignore_for_file: sqflite_depends_on_importing
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../../domain/local/models/anime/relation_genre_and_anime_entity.dart';
import '../../../../domain/local/models/anime/relation_producer_and_anime_entity.dart';
import '../../../../domain/local/models/anime/studio_entity.dart';
import '../../../../utils/constants/type_anime.dart';

part 'jikan_moe_database.g.dart';

@Database(version: 1, entities: [
  // Anime Entity
  AnimeEntity,
  GenreEntity,
  StudioEntity,
  RelationTitleSynonymAndAnime,
  RelationProducerAndAnimeEntity,
  RelationLicensorAndAnimeEntity,
  RelationStudioAndAnimeEntity,
  RelationGenreAndAnimeEntity,
])
abstract class JikanMoeDatabase extends FloorDatabase {

  AnimeDao get animeDao;

}
