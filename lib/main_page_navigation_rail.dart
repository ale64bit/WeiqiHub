import 'package:flutter/material.dart';
import 'package:wqhub/main_page.dart';

class MainPageNavigationRail extends StatefulWidget {
  final MainPageDestination currentDestination;
  final void Function(MainPageDestination) onDestinationSelected;

  const MainPageNavigationRail({
    super.key,
    required this.currentDestination,
    required this.onDestinationSelected,
  });

  @override
  State<MainPageNavigationRail> createState() => _MainPageNavigationRailState();
}

class _MainPageNavigationRailState extends State<MainPageNavigationRail> {
  late MainPageDestination _selectedDestination;

  @override
  void initState() {
    super.initState();
    _selectedDestination = widget.currentDestination;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedDestination.index,
      onDestinationSelected: (index) {
        if (index != _selectedDestination.index) {
          setState(() {
            _selectedDestination = MainPageDestination.values[index];
          });
          widget.onDestinationSelected(_selectedDestination);
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.sports_esports),
          label: Text('Play'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.fitness_center),
          label: Text('Train'),
        ),
      ],
    );
  }
}
