// This class defines what information is needed when a car is sold
class Sale {
  final int customerCpf;
  final int customerName;
  final DateTime soldWhen;
  final double priceSold;
  final double dealershipCut;
  final double businessCut;
  final double safetyCut;

  Sale(this.customerCpf, this.customerName, this.soldWhen, this.priceSold,
      this.dealershipCut, this.businessCut, this.safetyCut);
}
