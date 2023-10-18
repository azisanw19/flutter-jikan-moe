import 'package:flutter/material.dart';

class AnimeListBottomNavigation extends StatefulWidget {
  final Function(int currentPage)? onDestinationSelected;

  const AnimeListBottomNavigation({
    super.key,
    this.onDestinationSelected,
  });

  @override
  State<AnimeListBottomNavigation> createState() =>
      _AnimeListBottomNavigationState();
}

class _AnimeListBottomNavigationState extends State<AnimeListBottomNavigation> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _currentPageIndex = index;
        });

        if (widget.onDestinationSelected != null) {
          widget.onDestinationSelected!(index);
        }
      },
      selectedIndex: _currentPageIndex,
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
