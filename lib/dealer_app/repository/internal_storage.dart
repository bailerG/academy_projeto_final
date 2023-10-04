import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<File> _getLocalFile(String fileName) async {
    var dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$fileName');
  }

  Future<File> saveImageLocal(File imageFile, String imageName) async {
    final file = await _getLocalFile(imageName);
    var result = await file.writeAsBytes(file.readAsBytesSync());
    return result;
  }

  Future<File> loadFileLocal(String fileName) async {
    final file = await _getLocalFile(fileName);
    if (!file.existsSync()) {
      throw const FormatException('Could not locate file');
    }
    return file;
  }

  Future<File> savePDFLocal(Uint8List bytes, String pdfName) async {
    final file = await _getLocalFile(pdfName);
    var result = await file.writeAsBytes(bytes);
    return result;
  }
}
