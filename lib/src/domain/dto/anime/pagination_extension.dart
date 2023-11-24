import '../../local/models/anime/pagination_data.dart';
import '../../remote/models/pagination_response.dart';

extension PaginaionResponseExtension on PaginationResponse {
  PaginationData toPaginationData() => PaginationData(
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.items?.count,
    this.items?.total,
    this.items?.perPage,
      );
}