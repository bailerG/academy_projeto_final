import 'dart:convert';

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
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}
