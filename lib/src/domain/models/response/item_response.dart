/// count : 25
/// total : 25218
/// per_page : 25

class ItemResponse {
  ItemResponse({
    this.count,
    this.total,
    this.perPage,
  });

  ItemResponse.fromJson(dynamic json) {
    count = json['count'];
    total = json['total'];
    perPage = json['per_page'];
  }

  int? count;
  int? total;
  int? perPage;

  ItemResponse copyWith({
    int? count,
    int? total,
    int? perPage,
  }) =>
      ItemResponse(
        count: count ?? this.count,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['total'] = total;
    map['per_page'] = perPage;
    return map;
  }
}
