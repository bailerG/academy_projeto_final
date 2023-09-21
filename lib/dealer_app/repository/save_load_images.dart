import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<File> _getLocalImage(String imageName) async {
    var dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$imageName');
  }

  Future<File> saveImageLocal(File imageFile, String imageName) async {
    final file = await _getLocalImage(imageName);
    var result = await file.writeAsBytes(imageFile.readAsBytesSync());
    return result;
  }

  Future<File> loadImageLocal(String imageName) async {
    final file = await _getLocalImage(imageName);
    if (!file.existsSync()) {
      throw const FormatException('Could not locate file');
    }
    return file;
  }
}
