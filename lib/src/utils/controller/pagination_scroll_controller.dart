import 'package:flutter/material.dart';

/// A controller that is used to control the pagination of a list.
class PaginationScrollController extends ScrollController {
  /// The minimum number of pixels scrolled before a scroll event is sent.
  final double scrollThresholdPercentage;

  /// The first page of the pagination.
  final int firstPage;

  /// The callback that is called when the page changes.
  final Function(int page) onPageChanged;

  /// The current page of the pagination.
  late int _currentPage;

  int get currentPage => _currentPage;

  double _previousMaxScroll = 0.0;

  /// Creates a new [PaginationScrollController].
  PaginationScrollController({
    this.scrollThresholdPercentage = 0.8,
    this.firstPage = 1,
    required this.onPageChanged,
  }) : super() {
    _currentPage = firstPage;

    this.addListener(_onScroll);
  }

  /// dispose the scroll controller
  @override
  void dispose() {
    this.removeListener(_onScroll);
    super.dispose();
  }

  /// detect when the scroll is at the bottom of the page
  void _onScroll() {
    double maxScroll =
        this.position.maxScrollExtent * scrollThresholdPercentage;

    if (this.position.pixels >= maxScroll && maxScroll > _previousMaxScroll) {
      _previousMaxScroll = maxScroll;
      _currentPage++;
      onPageChanged(_currentPage);
    }
  }
}
