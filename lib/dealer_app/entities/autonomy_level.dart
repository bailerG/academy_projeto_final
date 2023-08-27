class AutonomyLevel {
  final int? id;
  final String name;
  final double dealershipPercentage;
  final double safetyPercentage;
  final double headquartersPercentage;

  AutonomyLevel({
    this.id,
    required this.name,
    required this.dealershipPercentage,
    required this.safetyPercentage,
    required this.headquartersPercentage,
  });
}
