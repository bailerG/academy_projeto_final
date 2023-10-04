import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import '../../usecases/pdf_template.dart';
import '../state/report_state.dart';
import '../utils/header.dart';
import '../utils/large_button.dart';
import '../utils/small_button.dart';

class ReportGenerationScreen extends StatelessWidget {
  const ReportGenerationScreen({super.key});

  static const routeName = '/report_generation';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportState(),
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
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppHeader(header: 'Date Range'),
          _DateRangePicker(state),
          AppLargeButton(
            onPressed: () async {
              final pdfDocument = PDFDocument();

              var file = await pdfDocument.generatePDF();
              await OpenFile.open(file.path);
            },
            text: 'Generate',
          )
        ],
      ),
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
