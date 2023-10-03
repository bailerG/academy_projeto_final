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

    List<Widget> widgetList;

    state.loggedUser!.roleId == 1
        ? widgetList = state.widgetOptionsAdmin
        : widgetList = state.widgetOptionsAssociate;

    return Scaffold(
      body: widgetList.elementAt(state.selectedIndex),
      bottomNavigationBar: const AppNavigationBar(),
      appBar: myAppBar(context),
    );
  }
}
