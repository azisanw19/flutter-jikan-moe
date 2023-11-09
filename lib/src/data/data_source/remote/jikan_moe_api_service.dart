import 'package:anime_list/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/remote/models/anime_response.dart';


part 'jikan_moe_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.JsonSerializable)
abstract class JikanMoeApiService {
  factory JikanMoeApiService(Dio dio, {String baseUrl}) = _JikanMoeApiService;

  @GET('/anime')
  Future<HttpResponse<AnimeResponse>> getAnimeSearch();

  @GET('/seasons/now')
  Future<HttpResponse<AnimeResponse>> getAnimeSeasonNow();

}