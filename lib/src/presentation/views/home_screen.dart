import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/presentation/state/home_request_state.dart';
import 'package:anime_list/src/presentation/state/home_response_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../components/jikan_moe_bottom_navigation.dart';
import '../components/jikan_moe_sliver_app_bar.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = context.read<HomeBloc>();
    homeBloc.add(RequestStateGetAnime());
    homeBloc.add(RequestStateGetAnimeSeasonNow());

    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: phoneWidth < 600 ? JikanMoeBottomNavigation() : null,
      body: _bodyCompactSize(context),
    );
  }

  Widget _bodyCompactSize(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: JikanMoeSliverAppBar(
            title: _titleHome(context, data: 'My Feed'),
          ),
        ),
      ],
      body: _contentHome(context),
    );
  }

  Widget _titleHome(BuildContext context, {required String data}) {
    return Text(data);
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
    return BlocBuilder<HomeBloc, ResponseStateHome>(
      buildWhen: (previous, current) => current is ResponseStateGetAnimeSeasonNow,
        builder: (context, responseStateHome) {
          if (responseStateHome is ResponseStateGetAnimeSeasonNow) {
            return Container();
            /* TODO make season now */
          }
          else {
            return Container();
          }
        },
    );
  }

  Widget _viewAnime(BuildContext context) {
    return BlocBuilder<HomeBloc, ResponseStateHome>(
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
