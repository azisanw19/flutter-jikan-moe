
import 'pagination_item_response.dart';

/// last_visible_page : 1009
/// has_next_page : true
/// current_page : 1

class PaginationResponse {
  PaginationResponse({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.items,
  });

  PaginationResponse.fromJson(dynamic json) {
    lastVisiblePage = json['last_visible_page'];
    hasNextPage = json['has_next_page'];
    currentPage = json['current_page'];
    items = PaginationItemResponse.fromJson(json['items']);
  }

  int? lastVisiblePage;
  bool? hasNextPage;
  int? currentPage;
  PaginationItemResponse? items;

  PaginationResponse copyWith({
    int? lastVisiblePage,
    bool? hasNextPage,
    int? currentPage,
    PaginationItemResponse? items,
  }) =>
      PaginationResponse(
        lastVisiblePage: lastVisiblePage ?? this.lastVisiblePage,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        currentPage: currentPage ?? this.currentPage,
        items: items ?? this.items,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['last_visible_page'] = lastVisiblePage;
    map['has_next_page'] = hasNextPage;
    map['current_page'] = currentPage;
    map['items'] = items;
    return map;
  }
}
