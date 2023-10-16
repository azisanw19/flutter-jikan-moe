import 'dart:async';

import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/domain/repository/anime_repository_local.dart';
import 'package:anime_list/src/domain/repository/anime_repository_remote.dart';
import 'package:anime_list/src/utils/error/repository_remote_exception.dart';
import 'package:anime_list/src/utils/error/use_case_exception.dart';
import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';
import 'package:anime_list/src/utils/resources/data_state_pagination.dart';
import 'package:dio/dio.dart';

import '../../domain/data_transfer_object/pagination_data.dart';

class AnimeSearchUseCase {
  final NetworkManager _networkManager;
  final AnimeRepositoryRemote _animeRepositoryRemote;
  final AnimeRepositoryLocal _animeRepositoryLocal;

  const AnimeSearchUseCase(this._networkManager, this._animeRepositoryRemote,
      this._animeRepositoryLocal);

  Future<DataState<Stream<List<AnimeData>>>> getAnimeSearch() async {
    bool isOnline = await _networkManager.isOnline;

    if (isOnline) {
      return _getDataFromRepositoryRemote();
    } else {
      return _getDataFromLocalRepository();
    }
  }

  Future<DataStatePagination<List<AnimeData>, PaginationData>>
      _getAnimeSearchRemoteRepository() =>
          _animeRepositoryRemote.getAnimeSearch();

  Future<DataState<Stream<List<AnimeData>>>>
      _getDataFromRepositoryRemote() async {
    DataStatePagination<List<AnimeData>, PaginationData>
        dataStatePaginationAnimeDataPaginationData =
        await _getAnimeSearchRemoteRepository();

    if (dataStatePaginationAnimeDataPaginationData
        is DataStatePaginationSuccess) {
      // save to Database
      return DataStateError(UseCaseException('exception'));
    } else if (dataStatePaginationAnimeDataPaginationData
        is DataStatePaginationError) {
      String stringException = _exceptionNotification(
          dataStatePaginationAnimeDataPaginationData.exception!);
      return DataStateError(UseCaseException(stringException));
    } else {
      return DataStateError(
          UseCaseException('An error occurred while retrieving data'));
    }
  }

  String _exceptionNotification(Exception exception) {
    if (exception is DioException) {
      return 'An error occurred while retrieving data';
    } else if (exception is RepositoryRemoteException) {
      return 'An error occurred while processing the data';
    } else {
      return 'Unhandled exception';
    }
  }

  Future<DataState<Stream<List<AnimeData>>>>
      _getDataFromLocalRepository() async {
    throw UnimplementedError();
  }
}
