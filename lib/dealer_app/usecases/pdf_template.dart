import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../entities/sale.dart';
import '../repository/internal_storage.dart';

class PDFDocument {
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
          pdfHeader(image),
          salesTable(list),
        ],
      ),
    );

    final bytes = await pdf.save();
    final pdfName = '/${DateTime.now()}.pdf';

    final pdfFile = await localStorage.savePDFLocal(bytes, pdfName);

    return pdfFile;
  }

  Widget pdfHeader(MemoryImage image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Header(
          child: Text(
            'September Report Sales'.toUpperCase(),
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

  Widget salesTable(List<Sale> list) {
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
      tableRows.add(saleTableRow(item));
    }

    return Table(
      border: TableBorder.all(),
      children: tableRows,
    );
  }

  TableRow saleTableRow(Sale sale) {
    return TableRow(
      children: [
        Text(sale.customerName),
        Text(
          DateFormat('dd/MM/yyyy').format(sale.soldWhen),
        ),
        Text(
          (sale.priceSold * sale.dealershipPercentage).toString(),
        ),
        Text(
          (sale.priceSold * sale.headquartersPercentage).toString(),
        ),
        Text(sale.priceSold.toString()),
      ],
    );
  }
}
