/// Represents a Model of Vehicle from Fipe Api
///
/// with [code] and [name] parameters.
class ModelEndpoint {
  /// Single number indentification of a Model from Fipe Api.
  final int? code;

  /// Name of a vehicle model from Fipe Api.
  final String? name;

  /// Constructs an instance of an [ModelEndpoint]
  ///
  /// with given [code] and [name] parameters.
  ModelEndpoint({
    this.code,
    this.name,
  });

  /// Translates a JSON response to an instance of [ModelEndpoint].
  factory ModelEndpoint.fromJson(Map<String, dynamic> json) => ModelEndpoint(
        code: json['codigo'],
        name: json['nome'],
      );

  @override
  String toString() {
    return name!;
  }
}
