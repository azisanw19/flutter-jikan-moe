import 'image_item_response.dart';

class ImageResponse {

  ImageResponse({
    this.jpg,
    this.webp,
  });

  ImageResponse.fromJson(Map<String, dynamic> json) {
    jpg = ImageItemResponse.fromJson(json['jpg']);
    webp = ImageItemResponse.fromJson(json['webp']);
  }

  ImageItemResponse? jpg;
  ImageItemResponse? webp;

  ImageResponse copyWith({
    ImageItemResponse? jpg,
    ImageItemResponse? webp,
  }) =>
      ImageResponse(
        jpg: jpg ?? this.jpg,
        webp: webp ?? this.webp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jpg'] = jpg;
    map['webp'] = webp;
    return map;
  }

}