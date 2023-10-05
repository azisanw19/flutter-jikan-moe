import 'package:flutter/material.dart';

class AnimeListNavigationRail extends StatefulWidget {

  final Function(int selectedIndex)? onDestinationSelected;

  AnimeListNavigationRail({super.key, this.onDestinationSelected});

  int _selectedIndex = 0;

  @override
  State<StatefulWidget> createState() => _AnimeListNavigationRailState();
}

class _AnimeListNavigationRailState extends State<AnimeListNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: widget._selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          widget._selectedIndex = index;
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