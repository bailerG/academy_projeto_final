import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        NavigationDestination(
          selectedIcon: const Icon(
            Icons.home,
            color: Colors.white,
          ),
          icon: const Icon(Icons.home_outlined),
          label: AppLocalizations.of(context)!.homeTab,
        ),
        NavigationDestination(
          selectedIcon: const Icon(
            Icons.add_box_rounded,
            color: Colors.white,
          ),
          icon: const Icon(Icons.add_box_outlined),
          label: AppLocalizations.of(context)!.vehicleTab,
        ),
        if (state.loggedUser!.roleId == 1)
          NavigationDestination(
            selectedIcon: const Icon(
              Icons.person_4_rounded,
              color: Colors.white,
            ),
            icon: const Icon(Icons.person_4_outlined),
            label: AppLocalizations.of(context)!.adminTab,
          ),
        NavigationDestination(
          selectedIcon: const Icon(
            Icons.discount_rounded,
            color: Colors.white,
          ),
          icon: const Icon(Icons.discount_outlined),
          label: AppLocalizations.of(context)!.salesTab,
        ),
        NavigationDestination(
          selectedIcon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          icon: const Icon(Icons.settings_outlined),
          label: AppLocalizations.of(context)!.settingsTab,
        ),
      ],
      selectedIndex: state.selectedIndex,
      onDestinationSelected: state.onItemTapped,
    );
  }
}
