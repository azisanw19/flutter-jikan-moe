import 'package:flutter/material.dart';

class AnimeListSliverAppBar extends StatelessWidget {

  final Widget title;

  const AnimeListSliverAppBar({super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title,
    );
  }

}