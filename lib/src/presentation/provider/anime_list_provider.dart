import 'package:anime_list/src/domain/repository/anime_repository.dart';
import 'package:anime_list/src/locator.dart';
import 'package:flutter/material.dart';

class AnimeListProvider with ChangeNotifier {
  final AnimeRepository _animeRepository = locator.get();
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }



}

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    print('increment');
    notifyListeners();
  }

}