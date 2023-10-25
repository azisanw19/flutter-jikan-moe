import 'package:flutter/material.dart';

class JikanMoeSliverAppBar extends StatelessWidget {

  final Widget title;

  const JikanMoeSliverAppBar({super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title,
    );
  }

}