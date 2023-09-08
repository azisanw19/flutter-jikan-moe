import 'package:anime_list/src/presentation/provider/anime_list_provider.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AnimeListScreen extends StatelessWidget {
  AnimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Rebuild Screen');
    return ChangeNotifierProvider(
      create: (context) => AnimeListProvider(),
      child: Consumer<AnimeListProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Anime List',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Text(context.read<AnimeListProvider>().count.toString()),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.read<AnimeListProvider>().increment(),
          ),
        ),
      ),
    );
  }

}