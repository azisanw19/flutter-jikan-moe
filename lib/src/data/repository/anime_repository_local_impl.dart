import 'package:anime_list/src/domain/local/models/anime_entity.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';

import '../data_source/local/dao/anime_dao.dart';

class AnimeRepositoryLocalImpl implements AnimeRepositoryLocal {

  final AnimeDao _animeDao;

  const AnimeRepositoryLocalImpl(this._animeDao);

  @override
  Future<int> clearAnimeRows() {
    Future<int> numberOfEffectedRow = _animeDao.clearAnimeRows();

    return numberOfEffectedRow;
  }

  @override
  Future<int> insertAnime(List<AnimeEntity> animeEntities) {
    Future<int> numberOfEffectedRow = _animeDao.insertAnime(animeEntities);

    return numberOfEffectedRow;
  }

}