class OtherItemResponse {
  OtherItemResponse({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  OtherItemResponse.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  int? malId;
  String? type;
  String? name;
  String? url;

  OtherItemResponse copyWith({
    int? malId,
    String? type,
    String? name,
    String? url,
  }) =>
      OtherItemResponse(
        malId: malId ?? this.malId,
        type: type ?? this.type,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mal_id'] = malId;
    map['type'] = type;
    map['name'] = name;
    map['url'] = url;
    return map;
  }

}
