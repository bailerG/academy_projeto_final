import 'dealership.dart';

/// Represents a Vehicle
///
///
/// with [id], [model], [plate], [brand], [builtYear],
/// [modelYear], [photos], [pricePaid],
/// [purchasedDate], [dealershipId], and [isSold] properties.
class Vehicle {
  /// Single unique indentification to each instance of Vehicle.
  final int? id;

  /// The model name from an instance of vehicle.
  final String model;

  /// The plate characteres from an instance of vehicle.
  final String plate;

  /// The brand/manufacturer name from an instance of vehicle.
  final String brand;

  /// The year the vehicle was built.
  final int builtYear;

  /// The year the model of a vehicle was marketed and sold as.
  final int modelYear;

  /// Contains the names of image files belonging to an instance of vehicle.
  final String? photos;

  /// The price paid by the dealership for the given vehicle.
  final double pricePaid;

  /// The date the vehicle was brought into the dealership.
  final DateTime purchasedDate;

  /// The [Dealership.id] from the dealership the vehicle was bought.
  final int dealershipId;

  /// Defines if an instance of vehicle is sold or not.
  final bool isSold;

  /// Constructs an instance of an [Vehicle]
  ///
  /// given the provided [id], [model], [plate], [brand], [builtYear],
  /// [modelYear], [photos], [pricePaid], [purchasedDate],
  /// [dealershipId], and [isSold] properties.
  Vehicle({
    this.id,
    required this.model,
    required this.plate,
    required this.brand,
    required this.builtYear,
    required this.modelYear,
    this.photos,
    required this.pricePaid,
    required this.purchasedDate,
    required this.dealershipId,
    required this.isSold,
  });

  @override
  String toString() {
    return '$brand $model $modelYear';
  }
}
