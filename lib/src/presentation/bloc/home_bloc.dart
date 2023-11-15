import 'package:anime_list/src/presentation/state/request_state_home.dart';
import 'package:anime_list/src/presentation/state/response_state_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<RequestStateHome, ResponseStateHome> {
  int navigationIndex = 0;

  HomeBloc() : super(ResponseStateNavigationChance(0)) {
    on<RequestStateNavigationChance>(_getNavigation);
  }

  void _getNavigation(
      RequestStateNavigationChance event, Emitter<ResponseStateHome> emit) {
    navigationIndex = event.index;

    emit(ResponseStateNavigationChance(navigationIndex));
  }
}
