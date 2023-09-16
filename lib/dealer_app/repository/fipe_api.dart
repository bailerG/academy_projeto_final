import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

List<FipeApi> fipeApiFromJson(String str) =>
    List<FipeApi>.from(json.decode(str).map(FipeApi.fromJson));

String fipeApiToJson(List<FipeApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FipeApi {
  final String code;
  final String name;

  FipeApi({
    required this.code,
    required this.name,
  });

  factory FipeApi.fromJson(Map<String, dynamic> json) => FipeApi(
        code: json['codigo'],
        name: json['nome'],
      );

  Map<String, dynamic> toJson() => {
        'codigo': code,
        'nome': name,
      };

  @override
  String toString() {
    return name;
  }
}

Future<List<FipeApi>?> getCarBrands() async {
  const url = 'https://parallelum.com.br/fipe/api/v1/carros/marcas/';
  final uri = Uri.parse(url);

  try {
    final response = await http.get(uri);
    log(response.body);

    final decodeResult = jsonDecode(response.body);

    final result = <FipeApi>[];

    for (final item in decodeResult) {
      result.add(
        FipeApi.fromJson(item),
      );
    }
    return result;
  } on Exception catch (e) {
    log('$e');
    return null;
  }
}

Future<FipeApi?> getCarModel(String brandCode) async {
  final url =
      'https://parallelum.com.br/fipe/api/v1/carros/marcas/$brandCode/modelos';
  final uri = Uri.parse(url);

  try {
    final response = await http.get(uri);
    log(response.body);

    return FipeApi.fromJson(
      jsonDecode(response.body),
    );
  } on Exception catch (e) {
    log('$e');
    return null;
  }
}
