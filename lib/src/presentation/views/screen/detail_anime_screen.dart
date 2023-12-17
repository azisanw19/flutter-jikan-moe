import 'package:anime_list/src/presentation/bloc/detail_anime_bloc.dart';
import 'package:anime_list/src/presentation/state/event_detail_anime.dart';
import 'package:anime_list/src/presentation/state/state_detail_anime.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
//ignore: must_be_immutable
class DetailAnimeScreen extends StatelessWidget {
  final int malIdAnime;

  DetailAnimeScreen(
      {Key? key, @PathParam('malIdAnime') required this.malIdAnime})
      : super(key: key);

  late DetailAnimeBloc _detailAnimeBloc;

  @override
  Widget build(BuildContext context) {
    _detailAnimeBloc = context.read<DetailAnimeBloc>();
    _detailAnimeBloc.add(EventDetailAnimeGet(malIdAnime));

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _mainBody(context, constraints.maxWidth);
        },
      ),
    );
  }

  Widget _mainBody(BuildContext context, double maxWidth) {
    double widthImage = maxWidth;
    double heightImage = (widthImage / 225) * 319;

    Widget _flexibleSpaceBar = FlexibleSpaceBar(
      background: BlocBuilder<DetailAnimeBloc, StateDetailAnime>(
        buildWhen: (previous, current) {
          if (current is StateDetailAnimeData) {
            return true;
          } else {
            return false;
          }
        },
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

    Widget _title = BlocBuilder<DetailAnimeBloc, StateDetailAnime>(
      buildWhen: (previous, current) {
        if (current is StateDetailAnimeData) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is StateDetailAnimeData) {
          return Text(
            state.data.titleEnglish ?? "",
          );
        } else {
          return Container();
        }
      },
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
            title: _title,
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
