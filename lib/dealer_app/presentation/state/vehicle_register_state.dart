import 'package:flutter/material.dart';

class VehicleRegisterState with ChangeNotifier {
  final formState = GlobalKey<FormState>();

  final _modelController = TextEditingController();
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();

  TextEditingController get modelController => _modelController;
  TextEditingController get plateController => _plateController;
  TextEditingController get brandController => _brandController;
}
