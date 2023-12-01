import 'package:anime_list/src/presentation/bloc/detail_anime_bloc.dart';
import 'package:anime_list/src/presentation/state/event_detail_anime.dart';
import 'package:anime_list/src/presentation/state/state_detail_anime.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/window_size/window_class.dart';
import '../../../utils/window_size/window_size_class.dart';

@RoutePage()
//ignore: must_be_immutable
class DetailAnimeScreen extends StatelessWidget {
  final int malIdAnime;

  DetailAnimeScreen(
      {Key? key, @PathParam('malIdAnime') required this.malIdAnime})
      : super(key: key);

  late DetailAnimeBloc _detailAnimeBloc;
  late WindowSizeClass _windowSizeClass;

  @override
  Widget build(BuildContext context) {
    _windowSizeClass = WindowSizeClass(context);

    _detailAnimeBloc = context.read<DetailAnimeBloc>();
    _detailAnimeBloc.add(EventDetailAnimeGet(malIdAnime));

    return Scaffold(
      body: _mainBody(context),
    );
  }

  Widget _mainBody(BuildContext context) {
    double divider = 1;
    if (_windowSizeClass.windowClass == WindowClass.Compact) {
      divider = 1;
    } else if (_windowSizeClass.windowClass == WindowClass.Medium) {
      divider = 2;
    } else if (_windowSizeClass.windowClass == WindowClass.Expanded) {
      divider = 2;
    }

    double widthImage = MediaQuery.of(context).size.width / divider;
    double heightImage = (widthImage / 225) * 319;

    Widget _flexibleSpaceBar = FlexibleSpaceBar(
      background: BlocBuilder<DetailAnimeBloc, StateDetailAnime>(
        builder: (context, state) {
          if (state is StateDetailAnimeData) {
            return Image.network(
              state.data.image ?? "",
              fit: BoxFit.cover,
            );
          } else {
            return Container();
          }
        },
      ),
    );

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: heightImage,
            pinned: false,
            snap: true,
            floating: true,
            title: Text("Detail Anime"),
            centerTitle: true,
            flexibleSpace: _flexibleSpaceBar,
          ),
        ];
      },
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
