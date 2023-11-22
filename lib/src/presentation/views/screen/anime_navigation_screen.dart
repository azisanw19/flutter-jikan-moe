import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnimeNavigationScreen extends StatelessWidget {
  const AnimeNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}