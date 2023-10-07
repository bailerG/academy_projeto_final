import 'dart:io';

import 'package:flutter/services.dart';
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

  Future<File> generatePDF(List<Sale> list) async {
    final localStorage = LocalStorage();
    final pdf = Document();
    final image = MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => <Widget>[
          _pdfHeader(image),
          _salesTable(list),
          _totalRow(),
        ],
      ),
    );

    final bytes = await pdf.save();
    final pdfName = '/${DateTime.now()}.pdf';

    final pdfFile = await localStorage.savePDFLocal(bytes, pdfName);

    return pdfFile;
  }

  Widget _pdfHeader(MemoryImage image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Header(
          child: Text(
            'Sales Report'.toUpperCase(),
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

  Widget _salesTable(List<Sale> list) {
    final tableRows = <TableRow>[
      TableRow(
        children: [
          Text('Customer'),
          Text('Sale Date'),
          Text('Dealership %'),
          Text('Headquarters %'),
          Text('Total'),
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

  Widget _totalRow() {
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
              Text('Total Dealership Amount:'),
              Text('R\$ $dealershipTotalAmount'),
            ],
          ),
          TableRow(
            children: [
              Text('Total Headquarters Amount:'),
              Text('R\$ $headquartersTotalAmount'),
            ],
          ),
          TableRow(
            children: [
              Text('Total Amount:'),
              Text('R\$ $totalAmount'),
            ],
          ),
        ],
      ),
    );
  }
}
