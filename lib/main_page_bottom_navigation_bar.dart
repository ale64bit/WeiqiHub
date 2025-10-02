import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/main_page.dart';

class MainPageBottomNavigationBar extends StatefulWidget {
  final MainPageDestination currentDestination;
  final void Function(MainPageDestination) onDestinationSelected;

  const MainPageBottomNavigationBar({
    super.key,
    required this.currentDestination,
    required this.onDestinationSelected,
  });

  @override
  State<MainPageBottomNavigationBar> createState() =>
      _MainPageBottomNavigationBarState();
}

class _MainPageBottomNavigationBarState
    extends State<MainPageBottomNavigationBar> {
  late MainPageDestination _selectedDestination;

  @override
  void initState() {
    super.initState();
    _selectedDestination = widget.currentDestination;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BottomNavigationBar(
      currentIndex: _selectedDestination.index,
      onTap: (index) {
        if (index != _selectedDestination.index) {
          setState(() {
            _selectedDestination = MainPageDestination.values[index];
          });
          widget.onDestinationSelected(_selectedDestination);
        }
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: loc.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports),
          label: loc.play,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: loc.train,
        ),
      ],
    );
  }
}
