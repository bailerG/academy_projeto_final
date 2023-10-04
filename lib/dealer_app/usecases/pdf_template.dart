import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

import '../repository/internal_storage.dart';

class PDFDocument {
  Future<File> generatePDF() async {
    final localStorage = LocalStorage();
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Text('Hello world!'),
        ),
      ),
    );

    final bytes = await pdf.save();
    final pdfName = '/${DateTime.now()}.pdf';

    final pdfFile = await localStorage.savePDFLocal(bytes, pdfName);

    return pdfFile;
  }
}
