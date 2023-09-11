import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/main_state.dart';

PreferredSizeWidget myAppBar(BuildContext context) {
  final state = Provider.of<MainState>(context, listen: true);

  return AppBar(
    title: Image.asset(
      'assets/logo.png',
      height: MediaQuery.sizeOf(context).height / 7,
    ),
    centerTitle: true,
    leading: IconButton(
      onPressed: state.toggleTheme,
      icon: state.lightTheme
          ? const Icon(Icons.light_mode)
          : const Icon(Icons.dark_mode),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
    ],
  );
}

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.ads_click_rounded),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.access_alarm),
        ),
      ],
    ),
  );
}
