import 'dart:async';

import 'package:anime_list/src/data/use_case/anime_search_use_case.dart';
import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/home_state.dart';


class HomeBloc extends Bloc<HomeState, List<AnimeData>> {

  final AnimeSearchUseCase _animeSearchUseCase;
  List<AnimeData> listAnimeData = <AnimeData>[];

  HomeBloc(this._animeSearchUseCase) : super(<AnimeData>[]) {

    _subscribeStreamAnimeData();

    on<GetAnimeState>(_getAnimeData);
  }

  void _subscribeStreamAnimeData() async {

    Stream<List<AnimeData>> streamData = await _animeSearchUseCase.getAnimeSearch();

    StreamSubscription<List<AnimeData>> subscriptionData = streamData.listen(print);

    subscriptionData.onData((futureListAnimeData) {
      this.listAnimeData = futureListAnimeData;

      add(GetAnimeState());
    });

  }

  void _getAnimeData(GetAnimeState event, Emitter<List<AnimeData>> emit) {
    emit(listAnimeData);
  }

}