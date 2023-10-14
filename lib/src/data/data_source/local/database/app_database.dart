import 'dart:async';

import 'package:anime_list/src/domain/local/models/anime_entity.dart';
import 'package:anime_list/src/domain/local/models/genre_entity.dart';
import 'package:anime_list/src/domain/local/models/relation_genre_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/relation_licensor_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/relation_producer_and_anime_entity.dart';
import 'package:anime_list/src/domain/local/models/studio_entity.dart';
import 'package:floor/floor.dart';

// ignore_for_file: sqflite_depends_on_importing
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [
  // Anime Entity
  AnimeEntity,
  GenreEntity,
  StudioEntity,
  RelationGenreAndAnimeEntity,
  RelationLicensorAndAnime,
  RelationProducerAndAnimeEntity
])
abstract class AppDatabase extends FloorDatabase {



}
