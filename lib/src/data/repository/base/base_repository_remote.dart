import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';

import '../../../utils/resources/data_state.dart';

abstract class BaseRepositoryRemote {
  /// This method is responsible of handling the given `request`, in which
  /// it returns generic based `DataState`.
  ///
  /// Returns `DataSuccess` that holds the generic data `T` if the response
  /// is successfully recieved.
  ///
  /// Returns `DataFailed` that holds a `DioError` instance if any error occurs
  /// while sending the request or recieving the response.
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataStateSuccess(httpResponse.data);
      }
      else {
        throw DioException(
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions
        );
      }
    }
    on DioException catch(error) {
      return DataStateError(error);
    }
  }
}
