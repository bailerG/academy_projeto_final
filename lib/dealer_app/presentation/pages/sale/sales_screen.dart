import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../state/main_state.dart';
import '../../utils/large_button.dart';
import 'report_screen.dart';
import 'sales_list_screen.dart';

/// References the sales options page.
///
/// It shows two button options referencing
/// to [SalesListScreen] and [ReportGenerationScreen].
class SalesScreen extends StatelessWidget {
  /// Constructs an instance of [SalesScreen].
  const SalesScreen({super.key});

  /// Name of route leading to this page.
  static const routeName = '/sale';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MainState>(context);
    final locale = AppLocalizations.of(context)!;

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
              text: locale.salesList,
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
              text: locale.generateReport,
            ),
          )
        ],
      ),
    );
  }
}
