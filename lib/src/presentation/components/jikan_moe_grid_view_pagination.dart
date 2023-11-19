import 'package:anime_list/src/utils/controller/pagination_scroll_controller.dart';
import 'package:flutter/material.dart';

class JikanMoeGridViewPagination extends StatefulWidget {
  final Axis scrollDirection;
  final SliverGridDelegate gridDelegate;
  final int itemCount;
  final bool shrinkWrap;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? onLoadingBuilder;
  final void Function(int page) onPageChanged;
  final int firstPage;
  final double scrollThresholdPercentage;

  const JikanMoeGridViewPagination({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    required this.itemCount,
    this.shrinkWrap = false,
    required this.itemBuilder,
    this.onLoadingBuilder = null,
    required this.onPageChanged,
    this.firstPage = 1,
    this.scrollThresholdPercentage = 0.8,
  });

  @override
  State<JikanMoeGridViewPagination> createState() =>
      _JikanMoeGridViewPaginationState();
}

class _JikanMoeGridViewPaginationState
    extends State<JikanMoeGridViewPagination> {

  late PaginationScrollController _paginationScrollController;

  @override
  void initState() {
    super.initState();
    _paginationScrollController = PaginationScrollController(
      onPageChanged: widget.onPageChanged,
      firstPage: widget.firstPage,
      scrollThresholdPercentage: widget.scrollThresholdPercentage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _paginationScrollController,
      scrollDirection: widget.scrollDirection,
      gridDelegate: widget.gridDelegate,
      itemCount: widget.onLoadingBuilder != null
          ? widget.itemCount + 1
          : widget.itemCount,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        if (widget.onLoadingBuilder != null &&
            index == widget.itemCount + 1) {
          return widget.onLoadingBuilder!(context, index);
        } else {
          return widget.itemBuilder(context, index);
        }
      },
    );
  }

  @override
  void dispose() {
    _paginationScrollController.dispose();
    super.dispose();
  }
}