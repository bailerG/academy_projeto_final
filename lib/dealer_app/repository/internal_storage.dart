import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

/// Represents all functionalities used to access the app's directory
///
/// such as saving and loading files.
class LocalStorage {
  Future<File> _getLocalFile(String fileName) async {
    var dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$fileName');
  }

  /// Saves images into directory's path
  /// by giving the [imageFile] and [imageName] parameters.
  Future<File> saveImageLocal(File imageFile, String imageName) async {
    final file = await _getLocalFile(imageName);
    var result = await file.writeAsBytes(imageFile.readAsBytesSync());
    return result;
  }

  /// Loads any file within the app's directory
  /// by giving the [fileName] parameter.
  Future<File> loadFileLocal(String fileName) async {
    final file = await _getLocalFile(fileName);
    if (!file.existsSync()) {
      throw const FormatException('Could not locate file');
    }
    return file;
  }

  /// Saves a PDF file into directory's path
  /// by giving the [bytes] and [pdfName] parameters.
  Future<File> savePDFLocal(Uint8List bytes, String pdfName) async {
    final file = await _getLocalFile(pdfName);
    var result = await file.writeAsBytes(bytes);
    return result;
  }
}
