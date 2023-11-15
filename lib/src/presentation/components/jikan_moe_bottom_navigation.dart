import 'package:flutter/material.dart';

class JikanMoeBottomNavigation extends StatefulWidget {
  final Function(int index)? onDestinationSelected;
  final List<Widget> destinations;

  const JikanMoeBottomNavigation({
    super.key,
    this.onDestinationSelected,
    required this.destinations,
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
      destinations: widget.destinations
    );
  }
}
