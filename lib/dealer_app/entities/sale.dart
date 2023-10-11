import 'dealership.dart';
import 'user.dart';
import 'vehicle.dart';

/// Represents a Sale
///
///
/// with [id], [customerCpf], [customerName], [soldWhen], [priceSold],
/// [dealershipPercentage], [headquartersPercentage], [safetyPercentage],
/// [vehicleId], [dealershipId], [userId], and [isComplete] properties.
class Sale {
  /// Single unique indentification to each instance of sale.
  final int? id;

  /// A brazilian indentification document number
  /// from the person who made a purchase.
  final int customerCpf;

  /// The name of the person who made a purchase.
  final String customerName;

  /// The date an instance of sale was made.
  final DateTime soldWhen;

  /// The earnings from an instance of sale.
  final double priceSold;

  /// The percentage from an instance of sale destined
  /// to the [Dealership] instance which made the sale.
  final double dealershipPercentage;

  /// The percentage from an instance of sale destined to headquarters.
  final double headquartersPercentage;

  /// The percentage from an instance of sale kept as a safety measurement.
  final double safetyPercentage;

  /// The [Vehicle.id] belonging to the vehicle sold.
  final int vehicleId;

  /// The [Dealership.id] belonging to the dealership that sold the vehicle.
  final int dealershipId;

  /// The [User.id] belonging to the user who sold the vehicle.
  final int userId;

  /// Defines if an instance of sale was completed or not.
  final bool isComplete;

  /// Constructs an instance of an [Sale]
  ///
  /// given the provided [id], [customerCpf], [customerName], [soldWhen],
  /// [priceSold], [dealershipPercentage], [headquartersPercentage],
  /// [safetyPercentage], [vehicleId], [dealershipId], [userId],
  /// and [isComplete] properties.
  Sale({
    this.id,
    required this.customerCpf,
    required this.customerName,
    required this.soldWhen,
    required this.priceSold,
    required this.dealershipPercentage,
    required this.headquartersPercentage,
    required this.safetyPercentage,
    required this.vehicleId,
    required this.dealershipId,
    required this.userId,
    required this.isComplete,
  });

  @override
  String toString() {
    return 'Vehicle sold to $customerName at $soldWhen';
  }
}
