import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';


abstract class AnimeRepositoryLocal {

  Future<DataState<void>> saveAnime(List<AnimeData> listAnimeData);
  Future<DataState<int>> clearAnimeRows();
  Stream<List<AnimeData>> getListAnime();

}