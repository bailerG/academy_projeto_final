// Constructor for the Sale object
class Sale {
  final int? id;
  final int customerCpf;
  final String customerName;
  final DateTime soldWhen;
  final double priceSold;
  final double dealershipPercentage;
  final double headquartersPercentage;
  final double safetyPercentage;
  final int vehicleId;
  final int dealershipId;
  final int userId;
  final bool isComplete;

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
