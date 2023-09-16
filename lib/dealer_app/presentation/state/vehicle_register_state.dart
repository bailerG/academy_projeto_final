import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../repository/fipe_api.dart';

class VehicleRegisterState with ChangeNotifier {
  VehicleRegisterState() {
    init();
  }

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

  final allBrands = <String>[];

  void init() async {
    final result = await getBrandNames();

    allBrands.addAll(result ?? []);
  }

  Future<List<String>?> getBrandNames() async {
    final brandsList = await getCarBrands();

    final brandNames = <String>[];

    if (brandsList != null) {
      for (final item in brandsList) {
        brandNames.add(item.name);
      }
    }
    return brandNames;
  }
}
