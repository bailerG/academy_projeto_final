// Constructor for the Car object
class Vehicle {
  final int? id;
  final String model;
  final String plate;
  final String brand;
  final int builtYear;
  final int modelYear;
  final String? photos;
  final double pricePaid;
  final DateTime purchasedWhen;
  final int dealershipId;
  final bool isSold;

  Vehicle({
    this.id,
    required this.model,
    required this.plate,
    required this.brand,
    required this.builtYear,
    required this.modelYear,
    this.photos,
    required this.pricePaid,
    required this.purchasedWhen,
    required this.dealershipId,
    required this.isSold,
  });

  @override
  String toString() {
    return '$brand $model $modelYear';
  }
}
