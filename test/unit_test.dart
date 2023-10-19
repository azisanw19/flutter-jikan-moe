import 'package:anime_list/src/data/data_source/local/dao/anime_dao.dart';
import 'package:anime_list/src/data/data_source/local/database/jikan_moe_database.dart';
import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/utils/constants/type_anime.dart';
import 'package:test/test.dart';

void main() {
  group('Database test', () {
    late JikanMoeDatabase database;
    late AnimeDao animeDao;

    setUp(() async {
      database = await $FloorJikanMoeDatabase.inMemoryDatabaseBuilder().build();
      animeDao = database.animeDao;
    });

    tearDown(() async {
      await database.close();
    });

    test('insert database', () async {
      final AnimeEntity animeEntity = AnimeEntity(
          2,
          'url',
          'image',
          'youtubeTrailerId',
          'youtubeTrailerImage',
          'titleDefault',
          'titleEnglish',
          'titleJapanese',
          TypeAnime.music,
          'source',
          1,
          'status',
          true,
          'airedFrom',
          'airedTo',
          'duration',
          'rating',
          1,
          1,
          1,
          1,
          1,
          'synopsis',
          'background',
          'season',
          'broadcastDay',
          'broadcastTime',
          'broadcastTimezone');
      await animeDao.insertAnime([animeEntity]);

      animeDao.getAnime().listen(expectAsync1(
        (actualList) {
          expect(animeEntity.malId, actualList?[0].malId);
        },
      ));
    });
  });
}
