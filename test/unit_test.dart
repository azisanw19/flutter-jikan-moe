import 'package:anime_list/src/data/data_source/local/database/jikan_moe_database.dart';
import 'package:test/test.dart';

void main() {
  group('Database test', () {
    late JikanMoeDatabase database;

    setUp(() async {
      database = await $FloorJikanMoeDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });
  });
}
