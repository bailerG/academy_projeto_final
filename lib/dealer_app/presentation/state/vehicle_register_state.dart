import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class VehicleRegisterState with ChangeNotifier {
  final formState = GlobalKey<FormState>();

  final _modelController = TextEditingController();
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _builtYearController = TextEditingController();
  final _modelYearController = TextEditingController();
  final _priceController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  TextEditingController get modelController => _modelController;
  TextEditingController get plateController => _plateController;
  TextEditingController get brandController => _brandController;
  TextEditingController get builtYearController => _builtYearController;
  TextEditingController get modelYearController => _modelYearController;
  TextEditingController get priceController => _priceController;
}
