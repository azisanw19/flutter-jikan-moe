import 'package:flutter/material.dart';

class AnimeListBottomNavigation extends StatefulWidget {
  final Function(int currentPage)? onDestinationSelected;

  AnimeListBottomNavigation({
    super.key,
    this.onDestinationSelected,
  });

  int _currentPageIndex = 0;

  @override
  State<AnimeListBottomNavigation> createState() =>
      _AnimeListBottomNavigationState();
}

class _AnimeListBottomNavigationState extends State<AnimeListBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          widget._currentPageIndex = index;
        });

        if (widget.onDestinationSelected != null) {
          widget.onDestinationSelected!(index);
        }
      },
      selectedIndex: widget._currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.feed),
          icon: Icon(Icons.feed_outlined),
          label: 'My Feed',
        ),
        NavigationDestination(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
      ],
    );
  }
}
