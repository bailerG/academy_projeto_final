import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/main_state.dart';
import '../utils/large_button.dart';
import 'report_screen.dart';
import 'sales_list_screen.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  static const routeName = '/sale';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MainState>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppLargeButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                  SalesListScreen.routeName,
                  arguments: state.loggedUser,
                );
              },
              text: 'See All Sales',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AppLargeButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                  ReportGenerationScreen.routeName,
                  arguments: state.loggedUser,
                );
              },
              text: 'Generate a Report',
            ),
          )
        ],
      ),
    );
  }
}
