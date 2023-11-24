import 'package:anime_list/src/utils/resources/data_state.dart';

import '../local/models/anime/anime_data.dart';


abstract class AnimeRepositoryLocal {

  Future<DataState<void>> saveAnime(List<AnimeData> listAnimeData);
  Future<DataState<List<AnimeData>>> getListAnime();

  Future<DataState<void>> saveAnimeThisSeason(List<AnimeData> listAnimeData);
  Future<DataState<List<AnimeData>>> getListAnimeSeasonNow(int limit, int offset);
  Future<DataState<void>> deleteAnimeThisSeason();
}