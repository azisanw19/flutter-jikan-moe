import 'package:anime_list/src/presentation/home/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/anime_repository.dart';

class HomeBloc extends Bloc<HomeState, dynamic> {

  final AnimeRepository _animeRepository;

  HomeBloc(this._animeRepository) : super(dynamic);

}