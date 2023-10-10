import 'image_item_response.dart';

class TrailerResponse {
  TrailerResponse({
    this.youtubeId,
    this.url,
    this.embedUrl,
    this.images,
  });

  TrailerResponse.fromJson(Map<String, dynamic> json) {
    youtubeId = json['youtube_id'];
    url = json['url'];
    embedUrl = json['embed_url'];
    images = ImageItemResponse.fromJson(json['images']);
  }

  String? youtubeId;
  String? url;
  String? embedUrl;
  ImageItemResponse? images;

  TrailerResponse copyWith({
    String? youtubeId,
    String? url,
    String? embedUrl,
    ImageItemResponse? images
  }) =>
      TrailerResponse(
        youtubeId: youtubeId ?? this.youtubeId,
        url: url ?? this.url,
        embedUrl: embedUrl ?? this.embedUrl,
        images: images ?? this.images,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['youtube_id'] = youtubeId;
    map['url'] = url;
    map['embed_url'] = embedUrl;
    map['images'] = images?.toJson();
    return map;
  }
}
