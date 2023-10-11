/// Represents a Brand from Fipe Api
///
/// with [code] and [name] parameters.
class BrandEndpoint {
  /// Single number indentification of a Brand from Fipe Api.
  final String? code;

  /// Name of a brand from Fipe Api.
  final String? name;

  /// Constructs an instance of an [BrandEndpoint]
  ///
  /// with given [code] and [name] parameters.
  BrandEndpoint({
    this.code,
    this.name,
  });

  /// Translates a JSON response to an instance of [BrandEndpoint].
  factory BrandEndpoint.fromJson(Map<String, dynamic> json) => BrandEndpoint(
        code: json['codigo'],
        name: json['nome'],
      );

  @override
  String toString() {
    return name!;
  }
}
