class PaginationItemResponse {
  PaginationItemResponse({
    this.count,
    this.total,
    this.perPage,
  });

  PaginationItemResponse.fromJson(dynamic json) {
    count = json['count'];
    total = json['total'];
    perPage = json['per_page'];
  }

  int? count;
  int? total;
  int? perPage;

  PaginationItemResponse copyWith({
    int? count,
    int? total,
    int? perPage,
  }) =>
      PaginationItemResponse(
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
