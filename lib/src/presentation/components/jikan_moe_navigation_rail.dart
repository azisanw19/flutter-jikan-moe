import 'package:flutter/material.dart';

class JikanMoeNavigationRail extends StatefulWidget {
  final Function(int selectedIndex)? onDestinationSelected;
  final bool extended;
  final List<NavigationRailDestination> destinations;

  const JikanMoeNavigationRail({
    super.key,
    this.onDestinationSelected,
    required this.extended,
    required this.destinations,
  });

  @override
  State<StatefulWidget> createState() => _JikanMoeNavigationRailState();
}

class _JikanMoeNavigationRailState extends State<JikanMoeNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      extended: widget.extended,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });

        if (widget.onDestinationSelected != null) {
          widget.onDestinationSelected!(index);
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: widget.destinations,
    );
  }
}
