import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../entities/brand_endpoint.dart';
import '../entities/model_endpoint.dart';

/// Makes a request getting all registered brands
///
///
/// then calls [BrandEndpoint.fromJson] and returns
/// a list of [BrandEndpoint] instances.
Future<List<BrandEndpoint>?> getCarBrands() async {
  const url = 'https://parallelum.com.br/fipe/api/v1/carros/marcas/';
  final uri = Uri.parse(url);

  try {
    final response = await http.get(uri);

    final decodeResult = jsonDecode(response.body);

    final result = <BrandEndpoint>[];

    for (final item in decodeResult) {
      result.add(
        BrandEndpoint.fromJson(item),
      );
    }
    return result;
  } on Exception catch (e) {
    log('$e');
    return null;
  }
}

/// Makes a request getting all registered models within the given [brandName]
///
///
/// then calls [ModelEndpoint.fromJson] and returns
/// a list of [ModelEndpoint] instances.
Future<List<ModelEndpoint>?> getCarModel(String brandName) async {
  final listOfBrands = await getCarBrands();

  var brand = listOfBrands!.firstWhere(
    (element) => element.name == brandName,
    orElse: () => BrandEndpoint(code: null),
  );

  if (brand.code != null) {
    final url =
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/${brand.code}/modelos/';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      final decodeResult = jsonDecode(response.body);
      log(decodeResult['modelos'].toString());

      final result = <ModelEndpoint>[];

      for (final item in decodeResult['modelos']) {
        result.add(
          ModelEndpoint.fromJson(item),
        );
      }
      return result;
    } on Exception catch (e) {
      log('$e');
      return null;
    }
  } else {
    return null;
  }
}
