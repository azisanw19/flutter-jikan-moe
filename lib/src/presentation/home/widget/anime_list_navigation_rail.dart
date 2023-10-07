import 'package:flutter/material.dart';

/// currently not used
class AnimeListNavigationRail extends StatefulWidget {

  final Function(int selectedIndex)? onDestinationSelected;

  const AnimeListNavigationRail({super.key, this.onDestinationSelected});

  @override
  State<StatefulWidget> createState() => _AnimeListNavigationRailState();
}

class _AnimeListNavigationRailState extends State<AnimeListNavigationRail> {
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