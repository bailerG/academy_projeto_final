import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/main_state.dart';
import '../utils/app_bar.dart';
import 'navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const routeName = '/main_screen';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MainState>(context, listen: true);
    return Scaffold(
      body: state.widgetOptions.elementAt(state.selectedIndex),
      bottomNavigationBar: const AppNavigationBar(),
      appBar: myAppBar(context),
    );
  }
}
