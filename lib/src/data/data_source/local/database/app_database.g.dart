// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

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
            'CREATE TABLE IF NOT EXISTS `table_anime` (`mal_id` INTEGER NOT NULL, `url` TEXT NOT NULL, `jpg_image_url` TEXT NOT NULL, `trailer_youtube_id` TEXT NOT NULL, `trailer_image_medium_image_url` TEXT NOT NULL, `title` TEXT NOT NULL, `title_english` TEXT NOT NULL, `title_japanese` TEXT NOT NULL, `type` INTEGER NOT NULL, `source` TEXT NOT NULL, `episodes` INTEGER NOT NULL, `status` TEXT NOT NULL, `airing` INTEGER NOT NULL, `aired_form` TEXT NOT NULL, `aired_to` TEXT NOT NULL, `duration` TEXT NOT NULL, `score` REAL NOT NULL, `scored_by` INTEGER NOT NULL, `rank` INTEGER NOT NULL, `popularity` INTEGER NOT NULL, `favorites` INTEGER NOT NULL, `synopsis` TEXT NOT NULL, `background` TEXT NOT NULL, `season` TEXT NOT NULL, `broadcast_day` TEXT NOT NULL, `broadcast_time` TEXT NOT NULL, `broadcast_timezone` TEXT NOT NULL, PRIMARY KEY (`mal_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_genre` (`mal_id` INTEGER NOT NULL, `type` TEXT NOT NULL, `name` TEXT NOT NULL, `url` TEXT NOT NULL, PRIMARY KEY (`mal_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_studio` (`mal_id` TEXT NOT NULL, `type` TEXT NOT NULL, `name` TEXT NOT NULL, `url` TEXT NOT NULL, PRIMARY KEY (`mal_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_genre_and_anime` (`mal_id_anime` INTEGER NOT NULL, `mal_id_genre` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_studio` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `mal_id_genre`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_licensor_and_anime` (`mal_id_anime` INTEGER NOT NULL, `mal_id_studio` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`mal_id_studio`) REFERENCES `table_studio` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `mal_id_studio`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_relation_producer_and_anime` (`mal_id_anime` INTEGER NOT NULL, `mal_id_studio` INTEGER NOT NULL, FOREIGN KEY (`mal_id_anime`) REFERENCES `table_anime` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`mal_id_studio`) REFERENCES `table_studio` (`mal_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`mal_id_anime`, `mal_id_studio`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }
}
