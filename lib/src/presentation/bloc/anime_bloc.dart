import 'package:anime_list/src/data/use_case/anime_search_use_case.dart';
import 'package:anime_list/src/data/use_case/anime_season_now_use_case.dart';
import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/presentation/state/response_state_anime.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/request_state_anime.dart';

class AnimeBloc extends Bloc<RequestStateAnime, ResponseStateAnime> {
  final AnimeSearchUseCase _animeSearchUseCase;
  final AnimeSeasonNowUseCase _animeSeasonNowUseCase;
  List<AnimeData> listAnimeData = <AnimeData>[];

  AnimeBloc(this._animeSearchUseCase, this._animeSeasonNowUseCase)
      : super(ResponseStateLoading()) {
    on<RequestStateGetAnime>(_getAnimeData);
    on<RequestStateGetAnimeSeasonNow>(_getAnimeSeasonNow);
  }

  void _getAnimeData(
      RequestStateGetAnime event, Emitter<ResponseStateAnime> emit) async {
    DataState<List<AnimeData>> dataStateListAnimeData =
        await _animeSearchUseCase.getAnimeSearch();

    ResponseStateAnime responseStateAnime;

    if (dataStateListAnimeData is DataStateSuccess) {
       responseStateAnime = ResponseStateGetAnime(dataStateListAnimeData.data!);
    } else if (dataStateListAnimeData is DataStateError) {
      responseStateAnime = ResponseStateError();
    } else {
      responseStateAnime = ResponseStateError();
    }

    emit(responseStateAnime);
  }

  void _getAnimeSeasonNow(RequestStateGetAnimeSeasonNow event,
      Emitter<ResponseStateAnime> emit) async {
    DataState<List<AnimeData>> dataStateListAnimeSeasonNowData =
        await _animeSeasonNowUseCase.getAnimeSeasonNow();

    ResponseStateAnime responseStateAnime;

    if (dataStateListAnimeSeasonNowData is DataStateSuccess) {
      responseStateAnime = ResponseStateGetAnimeSeasonNow(dataStateListAnimeSeasonNowData.data!);
    } else if (dataStateListAnimeSeasonNowData is DataStateError) {
      responseStateAnime = ResponseStateError();
    } else {
      responseStateAnime = ResponseStateError();
    }

    emit(responseStateAnime);
  }

}
