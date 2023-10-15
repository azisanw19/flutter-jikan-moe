import 'package:anime_list/src/data/repository/base/base_repository_local.dart';
import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/domain/local/models/anime/anime_entity.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';

import '../data_source/local/dao/anime_dao.dart';

class AnimeRepositoryLocalImpl extends BaseRepositoryLocal implements AnimeRepositoryLocal {
  final AnimeDao _animeDao;

  AnimeRepositoryLocalImpl(this._animeDao);

  @override
  Future<DataState<int>> clearAnimeRows() {
    Future<DataState<int>> futureDataStateNumberOfEffectedRow = getStateOf(
        request: () => _animeDao.clearAnimeRows()
    );

    return futureDataStateNumberOfEffectedRow;
  }

  @override
  Future<DataState<int>> insertAnime(List<AnimeEntity> animeEntities) {
    Future<DataState<int>> futureDataStateNumberOfEffectedRow = getStateOf(
        request: () => _animeDao.insertAnime(animeEntities)
    );

    return futureDataStateNumberOfEffectedRow;
  }

  Stream<List<AnimeData>> getAnime() {


    throw UnimplementedError();
  }

}