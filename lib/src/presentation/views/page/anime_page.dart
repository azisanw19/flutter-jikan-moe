import 'package:anime_list/src/presentation/components/jikan_moe_grid_view_pagination.dart';
import 'package:anime_list/src/utils/constants/int.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/data_transfer_object/anime_data.dart';
import '../../bloc/anime_bloc.dart';
import '../../state/request_state_anime.dart';
import '../../state/response_state_anime.dart';

//ignore: must_be_immutable
class AnimePage extends StatelessWidget {

  late AnimeBloc _animeBloc;

  @override
  Widget build(BuildContext context) {
    _animeBloc = context.read<AnimeBloc>();
    _animeBloc.add(RequestStateGetAnime());
    _animeBloc.add(RequestStateGetAnimeSeasonNow(firstPageAnimeSeasonNow));

    return _contentHome(context);
  }

  /// Content Home
  Widget _contentHome(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text('This Season',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Container(
            height: 700,
            width: MediaQuery.of(context).size.width,
            child: _animeSeasonNow(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text('Anime List',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: _viewAnime(context),
          ),
        ],
      ),
    );
  }

  /// Anime Season Now
  Widget _animeSeasonNow(BuildContext context) {
    return BlocBuilder<AnimeBloc, ResponseStateAnime>(
      buildWhen: (previous, current) =>
          current is ResponseStateGetAnimeSeasonNow,
      builder: (context, responseStateAnime) {
        if (responseStateAnime is ResponseStateGetAnimeSeasonNow) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _animeSeasonNowView(context, responseStateAnime.data),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _animeSeasonNowView(
      BuildContext context, List<AnimeData> listAnimeData) {
    return JikanMoeGridViewPagination(
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 3),
      ),
      shrinkWrap: true,
      itemCount: listAnimeData.length,
      itemBuilder: (context, index) {
        return _itemSeasonNow(
          context,
          src: listAnimeData[index].image ?? '',
          title: listAnimeData[index].titleDefault ??
              listAnimeData[index].titleEnglish ??
              '',
          subtitle: listAnimeData[index].titleJapanese ?? '',
        );
      },
      onPageChanged: (page) {
        _animeBloc.add(RequestStateGetAnimeSeasonNow(page));
      },
    );
  }

  /// Item Anime Season Now
  Widget _itemSeasonNow(BuildContext context,
      {required String src, required String title, required String subtitle}) {
    return Column(
      children: [
        Image.network(
          src,
          width: 225 / 2,
          height: 319 / 2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// View Anime
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

  /// List Anime
  Widget _listAnime(BuildContext context, List<AnimeData> listAnimeData) {
    return ListView.builder(
      itemCount: listAnimeData.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            listAnimeData[index].image ?? '',
            errorBuilder: (context, error, stackTrace) => CircleAvatar(
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
    );
  }
}
