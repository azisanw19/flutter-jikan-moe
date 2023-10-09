import 'package:anime_list/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/remote/anime_response.dart';

part 'anime_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.JsonSerializable)
abstract class AnimeApiService {
  factory AnimeApiService(Dio dio, {String baseUrl}) = _AnimeApiService;

  @GET('/anime')
  Future<HttpResponse<AnimeResponse>> getAnimeSearch();

}