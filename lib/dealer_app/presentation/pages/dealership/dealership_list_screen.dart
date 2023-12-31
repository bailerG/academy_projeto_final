import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../entities/dealership.dart';
import '../../state/dealership/dealership_list_state.dart';
import '../../utils/title.dart';
import 'dealership_register_screen.dart';

/// References to the view/edit dealerships page.
///
/// It allows admins to see a lsit of all
/// instances of [Dealership] registered and edit them if needed.
class DealershipListScreen extends StatelessWidget {
  /// Constructs an instance of [DealershipListScreen].
  const DealershipListScreen({super.key});

  /// Name of route leading to this page.
  static const routeName = '/dealership_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => DealershipListState(),
        child: Consumer<DealershipListState>(
          builder: (context, state, child) {
            return state.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _DealershipListStructure(state);
          },
        ),
      ),
    );
  }
}

class _DealershipListStructure extends StatelessWidget {
  const _DealershipListStructure(this.state);

  final DealershipListState state;

  @override
  Widget build(BuildContext context) {
    final dealershipList = state.dealershipList.reversed.toList();
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        bottom: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTitle(
              title: locale.dealershipListTitle,
            ),
            ListView.builder(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 56,
              ),
              shrinkWrap: true,
              itemCount: dealershipList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _DealershipListTile(
                dealership: dealershipList[index],
                state: state,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DealershipListTile extends StatelessWidget {
  const _DealershipListTile({
    required this.dealership,
    required this.state,
  });

  final Dealership dealership;
  final DealershipListState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: dealership.isActive
          ? InkSplash.splashFactory
          : NoSplash.splashFactory,
      onTap: () async {
        if (!dealership.isActive) {
          return;
        } else {
          await Navigator.of(context)
              .pushNamed(
                DealershipRegisterScreen.routeName,
                arguments: dealership,
              )
              .whenComplete(state.init);
        }
      },
      child: ListTile(
        enabled: dealership.isActive,
        title: Text(
          dealership.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          state.autonomyList
              .singleWhere(
                  (element) => element.id == dealership.autonomyLevelId)
              .name,
          style: const TextStyle(
            color: accentColor,
          ),
        ),
        subtitle: Text(
          dealership.cnpj.toString(),
        ),
      ),
    );
  }
}
