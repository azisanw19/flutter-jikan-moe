import 'package:flutter/material.dart';

/// currently not used
class JikanMoeNavigationRail extends StatefulWidget {

  final Function(int selectedIndex)? onDestinationSelected;

  const JikanMoeNavigationRail({super.key, this.onDestinationSelected});

  @override
  State<StatefulWidget> createState() => _JikanMoeNavigationRailState();
}

class _JikanMoeNavigationRailState extends State<JikanMoeNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });

        if(widget.onDestinationSelected != null) {
          widget.onDestinationSelected!(index);
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('First'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark_border),
          selectedIcon: Icon(Icons.book),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.star_border),
          selectedIcon: Icon(Icons.star),
          label: Text('Third'),
        ),
      ],
    );
  }
}