import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnimeListScreen extends StatelessWidget {
  AnimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime List'),
      ),
      body: Text('TEst'),
    );
  }

}