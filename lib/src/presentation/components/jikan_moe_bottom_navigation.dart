import 'package:flutter/material.dart';

class JikanMoeBottomNavigation extends StatefulWidget {
  final Function(int currentPage)? onDestinationSelected;

  const JikanMoeBottomNavigation({
    super.key,
    this.onDestinationSelected,
  });

  @override
  State<JikanMoeBottomNavigation> createState() =>
      _JikanMoeBottomNavigationState();
}

class _JikanMoeBottomNavigationState extends State<JikanMoeBottomNavigation> {
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
          icon: Icon(Icons.person_2_outlined),
          selectedIcon: Icon(Icons.person_2),
          label: 'Business',
        ),
      ],
    );
  }
}
