class PaginationData {
  final int? lastPage;

  final bool? hasNextPage;

  final int? currentPage;

  final int? count;

  final int? total;

  final int? numberOfPerPage;

  PaginationData(
    this.lastPage,
    this.hasNextPage,
    this.currentPage,
    this.count,
    this.total,
    this.numberOfPerPage,
  );
}
