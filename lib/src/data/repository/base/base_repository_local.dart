import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../utils/resources/data_state.dart';

abstract class BaseRepositoryLocal {
  /// This method is responsible of handling the given `request`, in which
  /// it returns generic based `DataState`.
  ///
  /// Returns `DataSuccess` that holds the generic data `T` if the response
  /// is successfully recieved.
  ///
  /// Returns `DataFailed` that holds a `IOException` instance if any error occurs
  /// while sending the request or recieving the response.
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<T> Function() request,
  }) async {
    try {
      final databaseResponse = await request();
      return DataStateSuccess(databaseResponse);
    }
    on IOException catch(error) {
      return DataStateError(error);
    }
  }
}
