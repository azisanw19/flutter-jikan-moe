import 'package:anime_list/src/presentation/components/jikan_moe_navigation_rail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../config/router/app_router.dart';
import '../../../utils/window_size/window_class.dart';
import '../../../utils/window_size/window_size_class.dart';
import '../../components/jikan_moe_bottom_navigation.dart';

@RoutePage()
//ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late WindowSizeClass _windowSizeClass;
  List<HomeNavigationItem> homeNavigationItems =
      HomeNavigationItem.values.toList();

  @override
  Widget build(BuildContext context) {
    /* initialization */
    _windowSizeClass = WindowSizeClass(context);

    List<PageRouteInfo> tabsRoute = [
      AnimeRoute(),
      MangaRoute(),
    ];

    return AutoTabsRouter(
      routes: tabsRoute,
      builder: (context, child) {
        return Scaffold(
          body: _bodyWindowSizeClass(context, child),
          bottomNavigationBar: _jikanMoeBottomNavigation(context),
        );
      },
    );
  }

  Widget? _jikanMoeBottomNavigation(BuildContext context) {
    TabsRouter tabsRouter = context.tabsRouter;
    if (_windowSizeClass.windowClass == WindowClass.Compact) {
      Widget jikanMoeBottomNavigation = JikanMoeBottomNavigation(
        destinations: homeNavigationItems
            .map(
              (item) => NavigationDestination(
                selectedIcon: Icon(item.selectedIcon),
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
        onDestinationSelected: (index) => tabsRouter.setActiveIndex(index),
      );

      return jikanMoeBottomNavigation;
    } else if (_windowSizeClass.windowClass == WindowClass.Medium) {
      return null;
    } else if (_windowSizeClass.windowClass == WindowClass.Expanded) {
      return null;
    }

    throw "This should never have happened";
  }

  Widget _bodyWindowSizeClass(BuildContext context, Widget child) {
    if (_windowSizeClass.windowClass == WindowClass.Compact) {
      return child;
    } else if (_windowSizeClass.windowClass == WindowClass.Medium) {
      return _bodyWindowClassMedium(context, child);
    } else if (_windowSizeClass.windowClass == WindowClass.Expanded) {
      return _bodyWindowClassExpanded(context, child);
    }

    throw 'This should never have happened';
  }

  Widget _bodyWindowClassMedium(BuildContext context, Widget child) {
    return Row(
      children: [
        _navigationRail(context, false),
        Expanded(
          child: child,
        ),
      ],
    );
  }

  Widget _bodyWindowClassExpanded(BuildContext context, Widget child) {
    return Row(
      children: [
        _navigationRail(context, false),
        Expanded(
          child: child,
        ),
      ],
    );
  }

  Widget _navigationRail(BuildContext context, bool extended) {
    TabsRouter tabsRouter = context.tabsRouter;
    return JikanMoeNavigationRail(
      extended: extended,
      onDestinationSelected: (index) => tabsRouter.setActiveIndex(index),
      destinations: homeNavigationItems
          .map(
            (item) => NavigationRailDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: Text(item.label),
            ),
          )
          .toList(),
    );
  }
}

enum HomeNavigationItem {
  Anime(
      label: 'Anime',
      icon: Icons.movie_filter_outlined,
      selectedIcon: Icons.movie_filter),
  Manga(
      label: "Manga",
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book);

  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const HomeNavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}
