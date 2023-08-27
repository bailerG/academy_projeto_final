// Constructor for the Sale object
class Sale {
  final int? id;
  final int customerCpf;
  final String customerName;
  final DateTime soldWhen;
  final double priceSold;
  final double dealershipCut;
  final double businessCut;
  final double safetyCut;
  final int vehicleId;
  final int dealershipId;
  final int userId;

  Sale({
    this.id,
    required this.customerCpf,
    required this.customerName,
    required this.soldWhen,
    required this.priceSold,
    required this.dealershipCut,
    required this.businessCut,
    required this.safetyCut,
    required this.vehicleId,
    required this.dealershipId,
    required this.userId,
  });
}
