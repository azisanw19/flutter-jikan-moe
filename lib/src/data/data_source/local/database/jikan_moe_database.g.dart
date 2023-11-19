// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jikan_moe_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorJikanMoeDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$JikanMoeDatabaseBuilder databaseBuilder(String name) =>
      _$JikanMoeDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$JikanMoeDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$JikanMoeDatabaseBuilder(null);
}

class _$JikanMoeDatabaseBuilder {
  _$JikanMoeDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$JikanMoeDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$JikanMoeDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<JikanMoeDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$JikanMoeDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$JikanMoeDatabase extends JikanMoeDatabase {
  _$JikanMoeDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AnimeDao? _animeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_anime` (`mal_id` INTEGER NOT NULL, `url` TEXT, `jpg_image_url` TEXT, `trailer_youtube_id` TEXT, `trailer_image_medium_image_url` TEXT, `title` TEXT, `title_english` TEXT, `title_japanese` TEXT, `type` INTEGER, `source` TEXT, `episodes` INTEGER, `status` TEXT, `airing` INTEGER, `aired_form` TEXT, `aired_to` TEXT, `duration` TEXT, `rating` TEXT, `score` REAL, `scored_by` INTEGER, `rank` INTEGER, `popularity` INTEGER, `favorites` INTEGER, `synopsis` TEXT, `background` TEXT, `season` TEXT, `broadcast_day` TEXT, `broadcast_time` TEXT, `broadcast_timezone` TEXT, PRIMARY KEY (`mal_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_genre` (`mal_id` INTEGER NOT NULL, `type` TEXT, `name` TEXT, `url` TEXT, PRIMARY KEY (`mal_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_studio` (`mal_id` INTEGER NOT NULL, `type` TEXT, `name` TEXT, `url` TEXT, PRIMARY KEY (`mal_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_title_synonym_and_anime` (`mal_id_anime` INTEGER NOT NULL, `title_synonym` TEXT NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `title_synonym`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_producer_and_anime` (`mal_id_anime` INTEGER NOT NULL, `mal_id_studio` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`mal_id_studio`) REFERENCES `table_studio` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `mal_id_studio`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_licensor_and_anime` (`mal_id_anime` INTEGER NOT NULL, `mal_id_studio` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`mal_id_studio`) REFERENCES `table_studio` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `mal_id_studio`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_studio_and_anime` (`mal_id_anime` INTEGER NOT NULL, `mal_id_studio` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`mal_id_studio`) REFERENCES `table_studio` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `mal_id_studio`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_genre_and_anime` (`mal_id_anime` INTEGER NOT NULL, `mal_id_genre` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`mal_id_genre`) REFERENCES `table_genre` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `mal_id_genre`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_season_now_and_anime` (`mal_id_relation_season_now_and_anime` INTEGER, `mal_id_anime` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_relation_season_now_and_anime`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AnimeDao get animeDao {
    return _animeDaoInstance ??= _$AnimeDao(database, changeListener);
  }
}

class _$AnimeDao extends AnimeDao {
  _$AnimeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _animeEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_anime',
            (AnimeEntity item) => <String, Object?>{
                  'mal_id': item.malId,
                  'url': item.url,
                  'jpg_image_url': item.image,
                  'trailer_youtube_id': item.youtubeTrailerId,
                  'trailer_image_medium_image_url': item.youtubeTrailerImage,
                  'title': item.titleDefault,
                  'title_english': item.titleEnglish,
                  'title_japanese': item.titleJapanese,
                  'type': item.type?.index,
                  'source': item.source,
                  'episodes': item.episodes,
                  'status': item.status,
                  'airing': item.airing == null ? null : (item.airing! ? 1 : 0),
                  'aired_form': item.airedFrom,
                  'aired_to': item.airedTo,
                  'duration': item.duration,
                  'rating': item.rating,
                  'score': item.score,
                  'scored_by': item.scoredBy,
                  'rank': item.rank,
                  'popularity': item.popularity,
                  'favorites': item.favorite,
                  'synopsis': item.synopsis,
                  'background': item.background,
                  'season': item.season,
                  'broadcast_day': item.broadcastDay,
                  'broadcast_time': item.broadcastTime,
                  'broadcast_timezone': item.broadcastTimezone
                }),
        _studioEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_studio',
            (StudioEntity item) => <String, Object?>{
                  'mal_id': item.malId,
                  'type': item.type,
                  'name': item.name,
                  'url': item.url
                }),
        _genreEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_genre',
            (GenreEntity item) => <String, Object?>{
                  'mal_id': item.malId,
                  'type': item.type,
                  'name': item.name,
                  'url': item.url
                }),
        _relationTitleSynonymAndAnimeInsertionAdapter = InsertionAdapter(
            database,
            'table_relation_title_synonym_and_anime',
            (RelationTitleSynonymAndAnime item) => <String, Object?>{
                  'mal_id_anime': item.malIdAnime,
                  'title_synonym': item.titleSynonym
                }),
        _relationProducerAndAnimeEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_relation_producer_and_anime',
            (RelationProducerAndAnimeEntity item) => <String, Object?>{
                  'mal_id_anime': item.malIdAnime,
                  'mal_id_studio': item.malIdStudio
                }),
        _relationLicensorAndAnimeEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_relation_licensor_and_anime',
            (RelationLicensorAndAnimeEntity item) => <String, Object?>{
                  'mal_id_anime': item.malIdAnime,
                  'mal_id_studio': item.malIdStudio
                }),
        _relationStudioAndAnimeEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_relation_studio_and_anime',
            (RelationStudioAndAnimeEntity item) => <String, Object?>{
                  'mal_id_anime': item.malIdAnime,
                  'mal_id_studio': item.malIdStudio
                }),
        _relationGenreAndAnimeEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_relation_genre_and_anime',
            (RelationGenreAndAnimeEntity item) => <String, Object?>{
                  'mal_id_anime': item.malIdAnime,
                  'mal_id_genre': item.malIdGenre
                }),
        _relationSeasonNowAndAnimeEntityInsertionAdapter = InsertionAdapter(
            database,
            'table_relation_season_now_and_anime',
            (RelationSeasonNowAndAnimeEntity item) => <String, Object?>{
                  'mal_id_relation_season_now_and_anime': item.malId,
                  'mal_id_anime': item.malIdAnime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AnimeEntity> _animeEntityInsertionAdapter;

  final InsertionAdapter<StudioEntity> _studioEntityInsertionAdapter;

  final InsertionAdapter<GenreEntity> _genreEntityInsertionAdapter;

  final InsertionAdapter<RelationTitleSynonymAndAnime>
      _relationTitleSynonymAndAnimeInsertionAdapter;

  final InsertionAdapter<RelationProducerAndAnimeEntity>
      _relationProducerAndAnimeEntityInsertionAdapter;

  final InsertionAdapter<RelationLicensorAndAnimeEntity>
      _relationLicensorAndAnimeEntityInsertionAdapter;

  final InsertionAdapter<RelationStudioAndAnimeEntity>
      _relationStudioAndAnimeEntityInsertionAdapter;

  final InsertionAdapter<RelationGenreAndAnimeEntity>
      _relationGenreAndAnimeEntityInsertionAdapter;

  final InsertionAdapter<RelationSeasonNowAndAnimeEntity>
      _relationSeasonNowAndAnimeEntityInsertionAdapter;

  @override
  Future<int?> clearAnimeSeasonNow() async {
    return _queryAdapter.query(
        'DELETE FROM table_relation_season_now_and_anime',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<AnimeEntity>?> getAnime() async {
    return _queryAdapter.queryList('SELECT * FROM table_anime',
        mapper: (Map<String, Object?> row) => AnimeEntity(
            row['mal_id'] as int,
            row['url'] as String?,
            row['jpg_image_url'] as String?,
            row['trailer_youtube_id'] as String?,
            row['trailer_image_medium_image_url'] as String?,
            row['title'] as String?,
            row['title_english'] as String?,
            row['title_japanese'] as String?,
            row['type'] == null ? null : TypeAnime.values[row['type'] as int],
            row['source'] as String?,
            row['episodes'] as int?,
            row['status'] as String?,
            row['airing'] == null ? null : (row['airing'] as int) != 0,
            row['aired_form'] as String?,
            row['aired_to'] as String?,
            row['duration'] as String?,
            row['rating'] as String?,
            row['score'] as double?,
            row['scored_by'] as int?,
            row['rank'] as int?,
            row['popularity'] as int?,
            row['favorites'] as int?,
            row['synopsis'] as String?,
            row['background'] as String?,
            row['season'] as String?,
            row['broadcast_day'] as String?,
            row['broadcast_time'] as String?,
            row['broadcast_timezone'] as String?));
  }

  @override
  Future<List<RelationTitleSynonymAndAnime>?> getRelationTitleSynonymAndAnime(
      int malIdAnime) async {
    return _queryAdapter.queryList(
        'SELECT * FROM table_relation_title_synonym_and_anime WHERE mal_id_anime = ?1',
        mapper: (Map<String, Object?> row) => RelationTitleSynonymAndAnime(row['mal_id_anime'] as int, row['title_synonym'] as String),
        arguments: [malIdAnime]);
  }

  @override
  Future<List<RelationProducerAndAnimeEntity>?> getRelationProducerAndAnime(
      int malIdAnime) async {
    return _queryAdapter.queryList(
        'SELECT * FROM table_relation_producer_and_anime WHERE mal_id_anime = ?1',
        mapper: (Map<String, Object?> row) => RelationProducerAndAnimeEntity(row['mal_id_anime'] as int, row['mal_id_studio'] as int),
        arguments: [malIdAnime]);
  }

  @override
  Future<StudioEntity?> getStudioFromId(int malIdStudio) async {
    return _queryAdapter.query('SELECT * FROM table_studio WHERE mal_id = ?1',
        mapper: (Map<String, Object?> row) => StudioEntity(
            row['mal_id'] as int,
            row['type'] as String?,
            row['name'] as String?,
            row['url'] as String?),
        arguments: [malIdStudio]);
  }

  @override
  Future<List<RelationLicensorAndAnimeEntity>?> getRelationLicensorAndAnime(
      int malIdAnime) async {
    return _queryAdapter.queryList(
        'SELECT * FROM table_relation_licensor_and_anime WHERE mal_id_anime = ?1',
        mapper: (Map<String, Object?> row) => RelationLicensorAndAnimeEntity(row['mal_id_anime'] as int, row['mal_id_studio'] as int),
        arguments: [malIdAnime]);
  }

  @override
  Future<List<RelationStudioAndAnimeEntity>?> getRelationStudioAndAnime(
      int malIdAnime) async {
    return _queryAdapter.queryList(
        'SELECT * FROM table_relation_studio_and_anime WHERE mal_id_anime = ?1',
        mapper: (Map<String, Object?> row) => RelationStudioAndAnimeEntity(
            row['mal_id_anime'] as int, row['mal_id_studio'] as int),
        arguments: [malIdAnime]);
  }

  @override
  Future<List<RelationGenreAndAnimeEntity>?> getRelationGenreAndAnime(
      int malIdAnime) async {
    return _queryAdapter.queryList(
        'SELECT * FROM table_relation_genre_and_anime WHERE mal_id_anime = ?1',
        mapper: (Map<String, Object?> row) => RelationGenreAndAnimeEntity(
            row['mal_id_anime'] as int, row['mal_id_genre'] as int),
        arguments: [malIdAnime]);
  }

  @override
  Future<GenreEntity?> getGenreFromId(int malIdGenre) async {
    return _queryAdapter.query('SELECT * FROM table_genre WHERE mal_id = ?1',
        mapper: (Map<String, Object?> row) => GenreEntity(
            row['mal_id'] as int,
            row['type'] as String?,
            row['name'] as String?,
            row['url'] as String?),
        arguments: [malIdGenre]);
  }

  @override
  Future<int?> clearAnimeRows() async {
    return _queryAdapter.query('DELETE FROM table_anime',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<RelationSeasonNowAndAnimeEntity>?> getIdAnimeSeasonNow(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM table_relation_season_now_and_anime LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) =>
            RelationSeasonNowAndAnimeEntity(row['mal_id_anime'] as int),
        arguments: [limit, offset]);
  }

  @override
  Future<AnimeEntity?> getAnimeFromId(int malIdAnime) async {
    return _queryAdapter.query('SELECT * FROM table_anime WHERE mal_id = ?1',
        mapper: (Map<String, Object?> row) => AnimeEntity(
            row['mal_id'] as int,
            row['url'] as String?,
            row['jpg_image_url'] as String?,
            row['trailer_youtube_id'] as String?,
            row['trailer_image_medium_image_url'] as String?,
            row['title'] as String?,
            row['title_english'] as String?,
            row['title_japanese'] as String?,
            row['type'] == null ? null : TypeAnime.values[row['type'] as int],
            row['source'] as String?,
            row['episodes'] as int?,
            row['status'] as String?,
            row['airing'] == null ? null : (row['airing'] as int) != 0,
            row['aired_form'] as String?,
            row['aired_to'] as String?,
            row['duration'] as String?,
            row['rating'] as String?,
            row['score'] as double?,
            row['scored_by'] as int?,
            row['rank'] as int?,
            row['popularity'] as int?,
            row['favorites'] as int?,
            row['synopsis'] as String?,
            row['background'] as String?,
            row['season'] as String?,
            row['broadcast_day'] as String?,
            row['broadcast_time'] as String?,
            row['broadcast_timezone'] as String?),
        arguments: [malIdAnime]);
  }

  @override
  Future<List<int>> insertAnime(List<AnimeEntity> listAnimeEntity) {
    return _animeEntityInsertionAdapter.insertListAndReturnIds(
        listAnimeEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertStudio(List<StudioEntity> listStudioEntity) {
    return _studioEntityInsertionAdapter.insertListAndReturnIds(
        listStudioEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertGenre(List<GenreEntity> listGenreEntity) {
    return _genreEntityInsertionAdapter.insertListAndReturnIds(
        listGenreEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertRelationTitleSynonym(
      List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime) {
    return _relationTitleSynonymAndAnimeInsertionAdapter.insertListAndReturnIds(
        listRelationTitleSynonymAndAnime, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertRelationProducerAndAnime(
      List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity) {
    return _relationProducerAndAnimeEntityInsertionAdapter
        .insertListAndReturnIds(
            listRelationProducerAndAnimeEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertRelationLicensorAndAnime(
      List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity) {
    return _relationLicensorAndAnimeEntityInsertionAdapter
        .insertListAndReturnIds(
            listRelationLicensorAndAnimeEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertRelationStudioAndAnime(
      List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity) {
    return _relationStudioAndAnimeEntityInsertionAdapter.insertListAndReturnIds(
        listRelationStudioAndAnimeEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertRelationGenreAndAnime(
      List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity) {
    return _relationGenreAndAnimeEntityInsertionAdapter.insertListAndReturnIds(
        listRelationGenreAndAnimeEntity, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAnimeSeasonNow(
      List<RelationSeasonNowAndAnimeEntity>
          listRelationSeasonNowAndAnimeEntity) {
    return _relationSeasonNowAndAnimeEntityInsertionAdapter
        .insertListAndReturnIds(
            listRelationSeasonNowAndAnimeEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAnimeTransaction(
    List<AnimeEntity> listAnimeEntity,
    List<StudioEntity> listStudioEntity,
    List<GenreEntity> listGenreEntity,
    List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime,
    List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity,
    List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity,
    List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity,
    List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity,
  ) async {
    if (database is sqflite.Transaction) {
      await super.insertAnimeTransaction(
          listAnimeEntity,
          listStudioEntity,
          listGenreEntity,
          listRelationTitleSynonymAndAnime,
          listRelationProducerAndAnimeEntity,
          listRelationLicensorAndAnimeEntity,
          listRelationStudioAndAnimeEntity,
          listRelationGenreAndAnimeEntity);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$JikanMoeDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.animeDao.insertAnimeTransaction(
            listAnimeEntity,
            listStudioEntity,
            listGenreEntity,
            listRelationTitleSynonymAndAnime,
            listRelationProducerAndAnimeEntity,
            listRelationLicensorAndAnimeEntity,
            listRelationStudioAndAnimeEntity,
            listRelationGenreAndAnimeEntity);
      });
    }
  }

  @override
  Future<void> insertAnimeAndSeasonNowTransaction(
    List<AnimeEntity> listAnimeEntity,
    List<StudioEntity> listStudioEntity,
    List<GenreEntity> listGenreEntity,
    List<RelationTitleSynonymAndAnime> listRelationTitleSynonymAndAnime,
    List<RelationProducerAndAnimeEntity> listRelationProducerAndAnimeEntity,
    List<RelationLicensorAndAnimeEntity> listRelationLicensorAndAnimeEntity,
    List<RelationStudioAndAnimeEntity> listRelationStudioAndAnimeEntity,
    List<RelationGenreAndAnimeEntity> listRelationGenreAndAnimeEntity,
    List<RelationSeasonNowAndAnimeEntity> listRelationSeasonNowAndAnimeEntity,
  ) async {
    if (database is sqflite.Transaction) {
      await super.insertAnimeAndSeasonNowTransaction(
          listAnimeEntity,
          listStudioEntity,
          listGenreEntity,
          listRelationTitleSynonymAndAnime,
          listRelationProducerAndAnimeEntity,
          listRelationLicensorAndAnimeEntity,
          listRelationStudioAndAnimeEntity,
          listRelationGenreAndAnimeEntity,
          listRelationSeasonNowAndAnimeEntity);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$JikanMoeDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.animeDao.insertAnimeAndSeasonNowTransaction(
            listAnimeEntity,
            listStudioEntity,
            listGenreEntity,
            listRelationTitleSynonymAndAnime,
            listRelationProducerAndAnimeEntity,
            listRelationLicensorAndAnimeEntity,
            listRelationStudioAndAnimeEntity,
            listRelationGenreAndAnimeEntity,
            listRelationSeasonNowAndAnimeEntity);
      });
    }
  }

  @override
  Future<AnimeTable> getAllAnimeEntityToAnimeTable(
      AnimeEntity animeEntity) async {
    if (database is sqflite.Transaction) {
      return super.getAllAnimeEntityToAnimeTable(animeEntity);
    } else {
      return (database as sqflite.Database)
          .transaction<AnimeTable>((transaction) async {
        final transactionDatabase = _$JikanMoeDatabase(changeListener)
          ..database = transaction;
        return transactionDatabase.animeDao
            .getAllAnimeEntityToAnimeTable(animeEntity);
      });
    }
  }

  @override
  Future<List<AnimeTable>> getAnimeTable() async {
    if (database is sqflite.Transaction) {
      return super.getAnimeTable();
    } else {
      return (database as sqflite.Database)
          .transaction<List<AnimeTable>>((transaction) async {
        final transactionDatabase = _$JikanMoeDatabase(changeListener)
          ..database = transaction;
        return transactionDatabase.animeDao.getAnimeTable();
      });
    }
  }

  @override
  Future<List<AnimeTable>> getAnimeTableSeasonNow(
    int limit,
    int offset,
  ) async {
    if (database is sqflite.Transaction) {
      return super.getAnimeTableSeasonNow(limit, offset);
    } else {
      return (database as sqflite.Database)
          .transaction<List<AnimeTable>>((transaction) async {
        final transactionDatabase = _$JikanMoeDatabase(changeListener)
          ..database = transaction;
        return transactionDatabase.animeDao
            .getAnimeTableSeasonNow(limit, offset);
      });
    }
  }
}
