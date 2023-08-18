// Constructor for the Car object
class Vehicle {
  final String model;
  final String brand;
  final int builtYear;
  final String plate;
  final int modelYear;
  final String photo;
  final double pricePaid;
  final DateTime purchasedWhen;

  Vehicle(
      {required this.model,
      required this.brand,
      required this.builtYear,
      required this.plate,
      required this.modelYear,
      required this.photo,
      required this.pricePaid,
      required this.purchasedWhen});
}
