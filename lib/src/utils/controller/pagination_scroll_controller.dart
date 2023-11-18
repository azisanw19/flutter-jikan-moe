import 'package:flutter/material.dart';

/// A controller that is used to control the pagination of a list.
class PaginationScrollController {
  late ScrollController _scrollController;

  /// The minimum number of pixels scrolled before a scroll event is sent.
  final double scrollThresholdPercentage;

  /// The first page of the pagination.
  final int firstPage;

  /// The callback that is called when the page changes.
  final Function(int page) onPageChanged;

  /// The current page of the pagination.
  late int _currentPage;

  int get currentPage => _currentPage;

  /// Creates a new [PaginationScrollController].
  PaginationScrollController({
    this.scrollThresholdPercentage = 0.8,
    this.firstPage = 1,
    required this.onPageChanged,
  }) {
    _currentPage = firstPage;

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  /// dispose the scroll controller
  void dispose() {
    _scrollController.dispose();
  }

  /// detect when the scroll is at the bottom of the page
  void _onScroll() {
    double maxScroll =
        _scrollController.position.maxScrollExtent * scrollThresholdPercentage;

    if (_scrollController.position.pixels >= maxScroll) {
      _currentPage++;
      onPageChanged(_currentPage);
    }
  }
}
