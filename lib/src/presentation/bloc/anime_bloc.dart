import 'package:anime_list/src/presentation/state/state_anime.dart';
import 'package:anime_list/src/utils/constants/int.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/local/models/anime/anime_data.dart';
import '../../domain/repository/anime_repository_local.dart';
import '../../domain/use_case/anime_search_use_case.dart';
import '../../domain/use_case/anime_season_now_use_case.dart';
import '../../utils/controller/pagination_scroll_controller.dart';
import '../state/event_anime.dart';

class AnimeBloc extends Bloc<EventAnime, StateAnime> {
  final AnimeSearchUseCase _animeSearchUseCase;
  final AnimeSeasonNowUseCase _animeSeasonNowUseCase;
  final AnimeRepositoryLocal _animeRepositoryLocal;

  List<AnimeData> listSeasonNowAnimeData = [];

  PaginationScrollController paginationScrollController =
      PaginationScrollController(
    onPageChanged: (page) => print('page $page'),
  );

  AnimeBloc(this._animeSearchUseCase, this._animeSeasonNowUseCase,
      this._animeRepositoryLocal)
      : super(StateAnimeLoading()) {
    on<EventAnimeGet>(_getAnimeData);
    on<EventAnimeGetSeasonNow>(_getAnimeSeasonNow);
    on<EventDetailAnimeGet>(_getDetailAnimeData);
  }

  void _getAnimeData(EventAnimeGet event, Emitter<StateAnime> emit) async {
    DataState<List<AnimeData>> dataStateListAnimeData =
        await _animeSearchUseCase.getAnimeSearch();

    StateAnime responseStateAnime;

    if (dataStateListAnimeData is DataStateSuccess) {
      responseStateAnime = StateAnimeData(dataStateListAnimeData.data!);
    } else if (dataStateListAnimeData is DataStateError) {
      responseStateAnime = StateAnimeError();
    } else {
      responseStateAnime = StateAnimeError();
    }

    emit(responseStateAnime);
  }

  void _getAnimeSeasonNow(
      EventAnimeGetSeasonNow event, Emitter<StateAnime> emit) async {
    DataState<List<AnimeData>> dataStateListAnimeSeasonNowData =
        await _animeSeasonNowUseCase.getAnimeSeasonNow(event.page, limitPage);

    StateAnime responseStateAnime;

    if (dataStateListAnimeSeasonNowData is DataStateSuccess) {
      listSeasonNowAnimeData.addAll(dataStateListAnimeSeasonNowData.data!);
      responseStateAnime = StateAnimeDataSeasonNow(listSeasonNowAnimeData);
    } else if (dataStateListAnimeSeasonNowData is DataStateError) {
      responseStateAnime = StateAnimeError();
    } else {
      responseStateAnime = StateAnimeError();
    }

    emit(responseStateAnime);
  }

  void _getDetailAnimeData(
      EventDetailAnimeGet event, Emitter<StateAnime> emit) async {
    DataState<AnimeData> dataStateAnimeData =
        await _animeRepositoryLocal.getDetailAnime(event.malId);

    StateAnime responseStateAnime;

    if (dataStateAnimeData is DataStateSuccess) {
      responseStateAnime =
          StateDetailAnimeData(dataStateAnimeData.data!);
    } else if (dataStateAnimeData is DataStateError) {
      responseStateAnime = StateAnimeError();
    } else {
      responseStateAnime = StateAnimeError();
    }

    emit(responseStateAnime);
  }
}
