import 'dealership.dart';

/// Represents an Autonomy Level
///
///
/// with [id], [name], [dealershipPercentage], [safetyPercentage],
/// and [headquartersPercentage] properties.
class AutonomyLevel {
  /// Single unique indentification to each instance of autonomy level.
  final int? id;

  /// Name of an autonomy level.
  final String name;

  /// The percentage of a sale destined to a [Dealership].
  final double dealershipPercentage;

  /// The percentage of a sale kept as a safety measurement.
  final double safetyPercentage;

  /// The percentage of a sale destined to headquarters.
  final double headquartersPercentage;

  /// Constructs an instance of an [AutonomyLevel]
  ///
  /// given the provided [id], [name], [dealershipPercentage],
  /// [safetyPercentage], and [headquartersPercentage] properties.
  AutonomyLevel({
    this.id,
    required this.name,
    required this.dealershipPercentage,
    required this.safetyPercentage,
    required this.headquartersPercentage,
  });

  @override
  String toString() {
    return name;
  }
}
