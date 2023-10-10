class TitleItemResponse {
  TitleItemResponse({
    this.type,
    this.title,
  });

  TitleItemResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
  }

  String? type;
  String? title;

  TitleItemResponse copyWith({
    String? type,
    String? title,
  }) =>
      TitleItemResponse(
        type: type ?? this.type,
        title: title ?? this.title,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    return map;
  }
}
