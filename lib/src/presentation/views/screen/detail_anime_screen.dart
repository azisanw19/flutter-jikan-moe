import 'package:anime_list/src/presentation/bloc/detail_anime_bloc.dart';
import 'package:anime_list/src/presentation/state/request_state_detail_anime.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
//ignore: must_be_immutable
class DetailAnimeScreen extends StatelessWidget {
  final int malIdAnime;

  DetailAnimeScreen({Key? key, @PathParam('malIdAnime') required this.malIdAnime}) : super(key: key);

  late DetailAnimeBloc _detailAnimeBloc;

  @override
  Widget build(BuildContext context) {
    _detailAnimeBloc = context.read<DetailAnimeBloc>();
    _detailAnimeBloc.add(RequestStateGetDetailAnime(malIdAnime));

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Anime'),
      ),
      body: Center(
        child: Text('Detail Anime'),
      ),
    );
  }
}
