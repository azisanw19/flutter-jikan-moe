import 'package:anime_list/src/presentation/bloc/home_bloc.dart';
import 'package:anime_list/src/presentation/components/jikan_moe_navigation_rail.dart';
import 'package:anime_list/src/presentation/state/request_state_home.dart';
import 'package:anime_list/src/presentation/state/response_state_home.dart';
import 'package:anime_list/src/presentation/views/page/anime_page.dart';
import 'package:anime_list/src/presentation/views/page/manga_page.dart';
import 'package:anime_list/src/utils/windowSize/window_class.dart';
import 'package:anime_list/src/utils/windowSize/window_size_class.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../components/jikan_moe_bottom_navigation.dart';
import '../../components/jikan_moe_sliver_app_bar.dart';

@RoutePage()
//ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late HomeBloc _homeBloc;
  late WindowSizeClass _windowSizeClass;

  final List<Widget> _navigationPages = [
    AnimePage(),
    MangaPage()
  ];

  final List<String> navigationTitleAppBar = ['Anime', 'Manga'];

  @override
  Widget build(BuildContext context) {
    /* initialization */
    _windowSizeClass = WindowSizeClass(context);
    _homeBloc = context.read<HomeBloc>();

    return Scaffold(
      bottomNavigationBar: _jikanMoeBottomNavigation(context),
      body: _bodyWindowSizeClass(context),
    );
  }

  Widget? _jikanMoeBottomNavigation(BuildContext context) {
    if (_windowSizeClass.windowClass == WindowClass.Compact) {
      Widget jikanMoeBottomNavigation = JikanMoeBottomNavigation(
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(MdiIcons.movieOpen),
            icon: Icon(MdiIcons.movieOpenOutline),
            label: 'Anime',
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.bookOpenPageVariant),
            selectedIcon: Icon(MdiIcons.bookOpenPageVariantOutline),
            label: 'Manga',
          ),
        ],
        onDestinationSelected: (index) =>
            _homeBloc.add(RequestStateNavigationChance(index)),
      );

      return jikanMoeBottomNavigation;
    } else if (_windowSizeClass.windowClass == WindowClass.Medium) {
      return null;
    } else if (_windowSizeClass.windowClass == WindowClass.Expanded) {
      return null;
    }

    throw "This should never have happened";
  }

  Widget _bodyWindowSizeClass(BuildContext context) {
    if (_windowSizeClass.windowClass == WindowClass.Compact) {
      return _bodyWindowClassCompact(context);
    } else if (_windowSizeClass.windowClass == WindowClass.Medium) {
      return _bodyWindowClassMedium(context);
    } else if (_windowSizeClass.windowClass == WindowClass.Expanded) {
      return _bodyWindowClassExpanded(context);
    }

    throw 'This should never have happened';
  }

  Widget _bodyWindowClassCompact(BuildContext context) {
    Widget jikanMoeSliverAppBar = JikanMoeSliverAppBar(
      title: BlocBuilder<HomeBloc, ResponseStateHome>(
        buildWhen: (previous, current) =>
        current is ResponseStateNavigationChance,
        builder: (context, responseStateHome) {
          if (responseStateHome is ResponseStateNavigationChance) {
            return Text(navigationTitleAppBar[responseStateHome.index]);
          } else {
            return Container();
          }
        },
      ),
    );

    Widget bodyCompact = BlocBuilder<HomeBloc, ResponseStateHome>(
      buildWhen: (previous, current) =>
      current is ResponseStateNavigationChance,
      builder: (context, responseStateHome) {
        if (responseStateHome is ResponseStateNavigationChance) {
          return LazyIndexedStack(
            index: responseStateHome.index,
            children: _navigationPages,
          );
        } else {
          return Container();
        }
      },
    );

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        jikanMoeSliverAppBar,
      ],
      body: bodyCompact,
    );
  }

  Widget _bodyWindowClassMedium(BuildContext context) {
    return Row(
      children: [
        _navigationRail(context, false),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _navigationRail(BuildContext context, bool extended) {
    return JikanMoeNavigationRail(
      extended: extended,
      destinations: [
        NavigationRailDestination(
          icon: Icon(MdiIcons.movieOpen),
          selectedIcon: Icon(MdiIcons.movieOpenOutline),
          label: Text('Anime'),
        ),
        NavigationRailDestination(
          icon: Icon(MdiIcons.bookOpenPageVariant),
          selectedIcon: Icon(MdiIcons.bookOpenPageVariantOutline),
          label: Text('Manga'),
        ),
      ],
    );
  }

  Widget _bodyWindowClassExpanded(BuildContext context) {
    return Row(
      children: [
        _navigationRail(context, false),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
