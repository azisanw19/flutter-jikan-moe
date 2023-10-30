class ImageItemResponse {
  ImageItemResponse({
    this.imageUrl,
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
    this.maximumImageUrl,
  });

  ImageItemResponse.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
    mediumImageUrl = json['medium_image_url'];
    largeImageUrl = json['large_image_url'];
    maximumImageUrl = json['maximum_image_url'];
  }

  String? imageUrl;
  String? smallImageUrl;
  String? mediumImageUrl;
  String? largeImageUrl;
  String? maximumImageUrl;

  ImageItemResponse copyWith({
    String? imageUrl,
    String? smallImageUrl,
    String? mediumImageUrl,
    String? largeImageUrl,
    String? maximumImageUrl,
  }) =>
      ImageItemResponse(
        imageUrl: imageUrl ?? this.imageUrl,
        smallImageUrl: smallImageUrl ?? this.smallImageUrl,
        mediumImageUrl: mediumImageUrl ?? this.mediumImageUrl,
        largeImageUrl: largeImageUrl ?? this.largeImageUrl,
        maximumImageUrl: maximumImageUrl ?? this.maximumImageUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_url'] = imageUrl;
    map['small_image_url'] = smallImageUrl;
    map['medium_image_url'] = mediumImageUrl;
    map['large_image_url'] = largeImageUrl;
    map['maximum_image_url'] = maximumImageUrl;
    return map;
  }
}