import 'package:anime_list/src/presentation/home/widget/anime_list_bottom_navigation.dart';
import 'package:anime_list/src/presentation/home/widget/anime_list_navigation_rail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: phoneWidth < 600 ? AnimeListBottomNavigation() : null,
      appBar: AppBar(
        title: Text('Anime List'),
      ),
      body: Row(
        children: [
          phoneWidth >= 600 ? AnimeListNavigationRail() : const SizedBox(),
        ],
      ),
    );
  }
}