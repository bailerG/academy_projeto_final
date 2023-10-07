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
      destinations: <Widget>[
        const NavigationDestination(
          selectedIcon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        const NavigationDestination(
          selectedIcon: Icon(
            Icons.add_box_rounded,
            color: Colors.white,
          ),
          icon: Icon(Icons.add_box_outlined),
          label: 'Add Vehicle',
        ),
        if (state.loggedUser!.roleId == 1)
          const NavigationDestination(
            selectedIcon: Icon(
              Icons.person_4_rounded,
              color: Colors.white,
            ),
            icon: Icon(Icons.person_4_outlined),
            label: 'Admin',
          ),
        const NavigationDestination(
          selectedIcon: Icon(
            Icons.discount_rounded,
            color: Colors.white,
          ),
          icon: Icon(Icons.discount_outlined),
          label: 'Sales',
        ),
        const NavigationDestination(
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
