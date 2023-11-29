import 'package:anime_list/src/utils/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/local/models/anime/anime_data.dart';
import '../../domain/repository/anime_repository_local.dart';
import '../state/request_state_detail_anime.dart';
import '../state/response_state_detail_anime.dart';

class DetailAnimeBloc
    extends Bloc<RequestStateDetailAnime, ResponseStateDetailAnime> {
  final AnimeRepositoryLocal _animeRepositoryLocal;

  DetailAnimeBloc(this._animeRepositoryLocal)
      : super(ResponseStateLoading()) {
    on<RequestStateGetDetailAnime>(_getDetailAnimeData);
  }

  void _getDetailAnimeData(RequestStateGetDetailAnime event,
      Emitter<ResponseStateDetailAnime> emit) async {
    DataState<AnimeData> dataStateAnimeData = await _animeRepositoryLocal
        .getDetailAnime(event.malId);

    ResponseStateDetailAnime responseStateGetDetailAnime;

    if (dataStateAnimeData is DataStateSuccess) {
      responseStateGetDetailAnime = ResponseStateGetDetailAnime(dataStateAnimeData.data!);
    } else if (dataStateAnimeData is DataStateError) {
      responseStateGetDetailAnime = ResponseStateError();
    } else {
      responseStateGetDetailAnime = ResponseStateError();
    }

    emit(responseStateGetDetailAnime);
  }

}