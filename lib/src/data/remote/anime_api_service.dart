import 'package:anime_list/src/domain/models/response/AnimeResponse.dart';
import 'package:anime_list/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'anime_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.JsonSerializable)
abstract class AnimeApiService {
  factory AnimeApiService(Dio dio, {String baseUrl}) = _AnimeApiService;

  @GET('/anime')
  Future<HttpResponse<AnimeResponse>> getAnimeSearch();

}