import 'package:flutter/material.dart';

class JikanMoeSliverAppBarImageExpanded extends StatelessWidget {
  final Widget background;
  final Widget title;

  const JikanMoeSliverAppBarImageExpanded({
    Key? key,
    required this.background,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: background
      ),
      title: title,
    );
  }
}