import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/data_transfer_object/anime_data.dart';
import '../../bloc/anime_bloc.dart';
import '../../state/request_state_anime.dart';
import '../../state/response_state_anime.dart';

class AnimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AnimeBloc homeBloc = context.read<AnimeBloc>();
    homeBloc.add(RequestStateGetAnime());
    homeBloc.add(RequestStateGetAnimeSeasonNow());

    return _contentHome(context);
  }

  Widget _contentHome(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        /* Anime Recommendation */

        _viewAnime(context),
      ],
    );
  }

  Widget _animeSeasonNow(BuildContext context) {
    return BlocBuilder<AnimeBloc, ResponseStateAnime>(
      buildWhen: (previous, current) =>
      current is ResponseStateGetAnimeSeasonNow,
      builder: (context, responseStateHome) {
        if (responseStateHome is ResponseStateGetAnimeSeasonNow) {
          return Container();
          /* TODO make season now */
        } else {
          return Container();
        }
      },
    );
  }

  Widget _viewAnime(BuildContext context) {
    return BlocBuilder<AnimeBloc, ResponseStateAnime>(
        buildWhen: (previous, current) => current is ResponseStateGetAnime,
        builder: (context, responseStateHome) {
          if (responseStateHome is ResponseStateGetAnime) {
            List<AnimeData> listAnimeData = responseStateHome.data;
            return _listAnime(context, listAnimeData);
          } else {
            return Container();
          }
        });
  }

  Widget _listAnime(BuildContext context, List<AnimeData> listAnimeData) {
    return Expanded(
      child: ListView.builder(
        itemCount: listAnimeData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              listAnimeData[index].image ?? '',
              errorBuilder: (context, error, stackTrace) =>
                  CircleAvatar(
                    child: Text(
                      listAnimeData[index].titleEnglish?[0] ?? 'J',
                    ),
                  ),
            ),
            title: Text(listAnimeData[index].titleEnglish ?? ''),
            subtitle: Text(listAnimeData[index].rating?.toString() ?? ''),
            trailing: Icon(Icons.more_vert),
          );
        },
      ),
    );
  }

  Widget _itemAnimeData(BuildContext context) {
    return ListTile(
      leading: FlutterLogo(size: 56.0),
      title: Text('Title not exist'),
      subtitle: Text('Here is a second line'),
      trailing: Icon(Icons.more_vert),
    );
  }

}