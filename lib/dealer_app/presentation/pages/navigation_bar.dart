import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../state/main_state.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MainState>(context, listen: true);

    return NavigationBar(
      indicatorColor: accentColor,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.add_box_rounded,
            color: Colors.white,
          ),
          icon: Icon(Icons.add_box_outlined),
          label: 'Add Vehicle',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.person_4_rounded,
            color: Colors.white,
          ),
          icon: Icon(Icons.person_4_outlined),
          label: 'Admin',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.padding_rounded,
            color: Colors.white,
          ),
          icon: Icon(Icons.padding_outlined),
          label: 'Report',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
      selectedIndex: state.selectedIndex,
      onDestinationSelected: state.onItemTapped,
    );
  }
}
