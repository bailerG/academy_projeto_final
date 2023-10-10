import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import '../../../entities/user.dart';
import '../../../usecases/pdf_template.dart';
import '../../state/sale/report_state.dart';
import '../../utils/dropdown.dart';
import '../../utils/header.dart';
import '../../utils/large_button.dart';
import '../../utils/small_button.dart';
import '../../utils/text_descriptions.dart';
import '../../utils/title.dart';

class ReportGenerationScreen extends StatelessWidget {
  const ReportGenerationScreen({super.key});

  static const routeName = '/report_generation';

  @override
  Widget build(BuildContext context) {
    final loggedUser = ModalRoute.of(context)!.settings.arguments as User;

    return ChangeNotifierProvider(
      create: (context) => ReportState(loggedUser),
      child: Consumer<ReportState>(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(),
            body: _ReportGenerationStructure(state),
          );
        },
      ),
    );
  }
}

class _ReportGenerationStructure extends StatelessWidget {
  const _ReportGenerationStructure(this.state);

  final ReportState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 40,
            ),
            child: _Title(),
          ),
          if (state.loggedUser.roleId == 1) _DealershipDropdown(state),
          AppHeader(
            header: locale.dateRangeHeader,
          ),
          _DateRangePicker(state),
          AppLargeButton(
            onPressed: () async {
              await state.getSales();

              final pdfDocument = PDFDocument();

              var file = await pdfDocument.generatePDF(state.salesList, locale);
              await OpenFile.open(file.path);
            },
            text: locale.pdfGenerateButton,
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        AppTitle(
          title: locale.reportScreenTitle,
        ),
        AppTextDescription(
          text: locale.reportScreenSubtitle,
        ),
      ],
    );
  }
}

class _DateRangePicker extends StatelessWidget {
  const _DateRangePicker(this.state);

  final ReportState state;

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

  final ReportState state;

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
