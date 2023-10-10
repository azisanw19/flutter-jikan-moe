import 'package:anime_list/src/presentation/home/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/anime_repository_remote.dart';

class HomeBloc extends Bloc<HomeState, dynamic> {

  final AnimeRepositoryRemote _animeRepository;

  HomeBloc(this._animeRepository) : super(dynamic);

  void test() async {
    _animeRepository.getAnimeSearch();

  }

}