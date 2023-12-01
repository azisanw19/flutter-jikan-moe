import 'package:anime_list/src/utils/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/local/models/anime/anime_data.dart';
import '../../domain/repository/anime_repository_local.dart';
import '../state/event_detail_anime.dart';
import '../state/state_detail_anime.dart';

class DetailAnimeBloc
    extends Bloc<EventDetailAnime, StateDetailAnime> {
  final AnimeRepositoryLocal _animeRepositoryLocal;

  DetailAnimeBloc(this._animeRepositoryLocal)
      : super(StateDetailAnimeLoading()) {
    on<EventDetailAnimeGet>(_getDetailAnimeData);
  }

  void _getDetailAnimeData(EventDetailAnimeGet event,
      Emitter<StateDetailAnime> emit) async {
    DataState<AnimeData> dataStateAnimeData = await _animeRepositoryLocal
        .getDetailAnime(event.malId);

    StateDetailAnime responseStateGetDetailAnime;

    if (dataStateAnimeData is DataStateSuccess) {
      responseStateGetDetailAnime = StateDetailAnimeData(dataStateAnimeData.data!);
    } else if (dataStateAnimeData is DataStateError) {
      responseStateGetDetailAnime = StateDetailAnimeError();
    } else {
      responseStateGetDetailAnime = StateDetailAnimeError();
    }

    emit(responseStateGetDetailAnime);
  }

}