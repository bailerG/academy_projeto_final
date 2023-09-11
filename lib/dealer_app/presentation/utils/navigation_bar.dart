import 'package:flutter/material.dart';

import '../../../main.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
