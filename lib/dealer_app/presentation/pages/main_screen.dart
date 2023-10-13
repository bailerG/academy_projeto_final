import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/main_state.dart';
import '../utils/app_bar.dart';
import 'navigation_bar.dart';

/// References the highest hierarchy page of the app.
///
/// It contains the personalized [myAppBar] and [AppNavigationBar],
/// all pages are shown within this page as it doesn't have a
/// fixed body property.
class MainScreen extends StatelessWidget {
  /// Constructs an instance of [MainScreen].
  const MainScreen({super.key});

  /// Name of route leading to this page.
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
