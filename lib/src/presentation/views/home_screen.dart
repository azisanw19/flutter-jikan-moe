import 'package:anime_list/src/domain/data_transfer_object/anime_data.dart';
import 'package:anime_list/src/presentation/state/home_state.dart';
import 'package:anime_list/src/utils/resources/data_state.dart';
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
    homeBloc.add(GetAnimeState());

    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: phoneWidth < 600 ? JikanMoeBottomNavigation() : null,
      body: _bodyCompactSize(context),
    );
  }

  Widget _bodyCompactSize(BuildContext context) {
    return CustomScrollView(
      slivers: [
        JikanMoeSliverAppBar(
          title: _titleHome(context, data: 'My Feed'),
        ),
        SliverFillRemaining(
          child: _contentHome(context),
        ),
      ],
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

  Widget _viewAnime(BuildContext context) {
    return BlocBuilder<HomeBloc, DataState<List<AnimeData>>>(
        builder: (context, dataStateListAnimeData) {
      if (dataStateListAnimeData is DataStateLoading)
        return LinearProgressIndicator();
      else if (dataStateListAnimeData is DataStateSuccess)
        return Expanded(
          child: ListView.builder(
            itemCount: dataStateListAnimeData.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text(
                    dataStateListAnimeData.data![index].titleEnglish ?? ''),
                subtitle: Text(dataStateListAnimeData.data![index].popularity
                        ?.toString() ??
                    ''),
                trailing: Icon(Icons.more_vert),
              );
            },
          ),
        );
      else
        return Text(
            dataStateListAnimeData.exception?.toString() ?? 'Something wrong');
    });
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
