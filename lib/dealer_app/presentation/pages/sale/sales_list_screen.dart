import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../entities/sale.dart';
import '../../../entities/user.dart';
import '../../state/sale/sales_list_state.dart';
import '../../utils/alert_dialog.dart';
import '../../utils/dropdown.dart';
import '../../utils/header.dart';
import '../../utils/small_button.dart';
import '../../utils/text_descriptions.dart';
import '../../utils/title.dart';

/// References the list of sales' page of the app.
///
/// It shows a all instances of [Sale] from a certain
/// date range to the user. It is also possible to mark
/// a certain sale as uncomplete.
class SalesListScreen extends StatelessWidget {
  /// Constructs an instance of [SalesListScreen].
  const SalesListScreen({super.key});

  /// Name of route leading to this page.
  static const routeName = '/sales_list';

  @override
  Widget build(BuildContext context) {
    final loggedUser = ModalRoute.of(context)!.settings.arguments as User;

    return ChangeNotifierProvider(
      create: (context) => SalesListState(loggedUser),
      child: Consumer<SalesListState>(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(),
            body: _SalesListStructure(state),
          );
        },
      ),
    );
  }
}

class _SalesListStructure extends StatelessWidget {
  const _SalesListStructure(this.state);

  final SalesListState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            child: _ListTitle(),
          ),
          if (state.loggedUser.roleId == 1)
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                top: 20,
              ),
              child: _DealershipDropdown(state),
            ),
          _DateRangePicker(state),
          if (state.salesList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 40,
              ),
              child: _SalesListView(state),
            )
          else
            Padding(
              padding: const EdgeInsets.only(
                top: 80,
                left: 40,
                right: 40,
              ),
              child: AppHeader(
                header: locale.saleListEmpty,
              ),
            ),
        ],
      ),
    );
  }
}

class _ListTitle extends StatelessWidget {
  const _ListTitle();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        AppTitle(
          title: locale.saleListTitle,
        ),
        AppTextDescription(
          text: locale.saleListSubtitle,
        ),
      ],
    );
  }
}

class _DateRangePicker extends StatelessWidget {
  const _DateRangePicker(this.state);

  final SalesListState state;

  @override
  Widget build(BuildContext context) {
    var start = state.dateRange.start;
    var end = state.dateRange.end;

    Future<void> pickDateRange() async {
      var newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: state.dateRange,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (newDateRange == null) return;

      state.setDateRange(newDateRange);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppSmallButton(
            text: DateFormat('dd/MM/yyyy').format(start),
            onPressed: pickDateRange,
          ),
          AppSmallButton(
            text: DateFormat('dd/MM/yyyy').format(end),
            onPressed: pickDateRange,
          ),
        ],
      ),
    );
  }
}

class _DealershipDropdown extends StatelessWidget {
  const _DealershipDropdown(this.state);

  final SalesListState state;

  @override
  Widget build(BuildContext context) {
    void onChanged(value) {
      state.setDealership(value);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: AppDropdown(
        list: state.dealershipList,
        onChanged: onChanged,
      ),
    );
  }
}

class _SalesListView extends StatelessWidget {
  const _SalesListView(this.state);

  final SalesListState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.salesList.length,
      itemBuilder: (context, index) {
        return _SalesListTile(state.salesList[index], state);
      },
    );
  }
}

class _SalesListTile extends StatelessWidget {
  const _SalesListTile(this.sale, this.state);

  final Sale sale;

  final SalesListState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return ListTile(
      enabled: sale.isComplete,
      title: Text(sale.customerName),
      subtitle: Text(
        'R\$${NumberFormat('###,###,###.00').format(sale.priceSold)}',
      ),
      trailing: Text(
        DateFormat('dd/MM/yyyy').format(sale.soldWhen),
      ),
      leading: IconButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              if (!sale.isComplete) {
                return AppAlertDialog(
                  title: locale.saleAlertMessage,
                  buttons: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                );
              }
              return AppAlertDialog(
                title: locale.saleAlertTitle,
                message: locale.saleAlertMessage,
                buttons: [
                  TextButton(
                    onPressed: () async {
                      await state.setUncomplete(sale);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(locale.yes),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(locale.cancel),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.cancel_outlined),
      ),
    );
  }
}
