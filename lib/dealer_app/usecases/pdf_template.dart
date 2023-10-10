import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../entities/sale.dart';
import '../repository/internal_storage.dart';

class PDFDocument {
  double _totalAmount = 0;
  double _totalDealershipAmount = 0;
  double _totalHeadquartersAmount = 0;

  final formatNumber = NumberFormat('###,###,#00.00');

  Future<File> generatePDF(List<Sale> list, AppLocalizations locale) async {
    final localStorage = LocalStorage();
    final pdf = Document();
    final image = MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => <Widget>[
          _pdfHeader(image, locale),
          _salesTable(list, locale),
          _totalRow(locale),
        ],
      ),
    );

    final bytes = await pdf.save();
    final pdfName = '/${DateTime.now()}.pdf';

    final pdfFile = await localStorage.savePDFLocal(bytes, pdfName);

    return pdfFile;
  }

  Widget _pdfHeader(MemoryImage image, AppLocalizations locale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Header(
          child: Text(
            locale.pdfTitle,
            textScaleFactor: 2.0,
          ),
        ),
        Image(
          image,
          width: 120,
        ),
      ],
    );
  }

  Widget _salesTable(List<Sale> list, AppLocalizations locale) {
    final tableRows = <TableRow>[
      TableRow(
        children: [
          Text(locale.pdfCustomer),
          Text(locale.pdfSaleDate),
          Text(locale.pdfDealershipPercentage),
          Text(locale.pdfHeadquartersPercentage),
          Text(locale.pdfItemTotal),
        ],
      )
    ];

    for (final item in list) {
      tableRows.add(_saleTableRow(item));
    }

    return Table(
      border: TableBorder.all(),
      children: tableRows,
    );
  }

  TableRow _saleTableRow(Sale sale) {
    final dealershipSaleAmount = sale.priceSold * sale.dealershipPercentage;
    final headquartersSaleAmount = sale.priceSold * sale.headquartersPercentage;

    _totalAmount += sale.priceSold;
    _totalDealershipAmount += dealershipSaleAmount;
    _totalHeadquartersAmount += headquartersSaleAmount;

    return TableRow(
      children: [
        Text(sale.customerName),
        Text(
          DateFormat('dd/MM/yyyy').format(sale.soldWhen),
        ),
        Text(
          'R\$ ${formatNumber.format(dealershipSaleAmount)}',
        ),
        Text(
          'R\$ ${formatNumber.format(headquartersSaleAmount)}',
        ),
        Text(
          'R\$ ${formatNumber.format(sale.priceSold)}',
        ),
      ],
    );
  }

  Widget _totalRow(AppLocalizations locale) {
    final dealershipTotalAmount = formatNumber.format(
      _totalDealershipAmount,
    );

    final headquartersTotalAmount = formatNumber.format(
      _totalHeadquartersAmount,
    );

    final totalAmount = formatNumber.format(
      _totalAmount,
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        left: 180,
      ),
      child: Table(
        children: [
          TableRow(
            children: [
              Text(locale.pdfDealershipAmount),
              Text('R\$ $dealershipTotalAmount'),
            ],
          ),
          TableRow(
            children: [
              Text(locale.pdfHeadquartersAmount),
              Text('R\$ $headquartersTotalAmount'),
            ],
          ),
          TableRow(
            children: [
              Text(locale.pdfTotalAmount),
              Text('R\$ $totalAmount'),
            ],
          ),
        ],
      ),
    );
  }
}
