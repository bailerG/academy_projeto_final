// Constructor for the Sale object
class Sale {
  final int? id;
  final int customerCpf;
  final String customerName;
  final DateTime soldWhen;
  final double priceSold;
  final double dealershipPercentage;
  final double businessPercentage;
  final double safetyPercentage;
  final int vehicleId;
  final int dealershipId;
  final int userId;

  Sale({
    this.id,
    required this.customerCpf,
    required this.customerName,
    required this.soldWhen,
    required this.priceSold,
    required this.dealershipPercentage,
    required this.businessPercentage,
    required this.safetyPercentage,
    required this.vehicleId,
    required this.dealershipId,
    required this.userId,
  });

  @override
  String toString() {
    return 'Vehicle sold to $customerName at $soldWhen';
  }
}
