import 'package:anime_list/src/data/use_case/anime_search_use_case.dart';
import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/home_state.dart';

class HomeBloc extends Bloc<HomeState, DataState<List<AnimeData>>> {
  final AnimeSearchUseCase _animeSearchUseCase;
  List<AnimeData> listAnimeData = <AnimeData>[];

  HomeBloc(this._animeSearchUseCase) : super(DataStateLoading()) {
    on<GetAnimeState>(_getAnimeData);
  }

  void _getAnimeData(
      GetAnimeState event, Emitter<DataState<List<AnimeData>>> emit) async {
    DataState<List<AnimeData>> dataStateListAnimeData =
        await _animeSearchUseCase.getAnimeSearch();

    emit(dataStateListAnimeData);
  }
}
