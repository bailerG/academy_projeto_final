// Each Dealership should have it's own level of autonomy included here
enum AutonomyLevel { starter, intermediate, advanced, special }

// Constructor for Dealership object
class Dealership {
  final int cnpj;
  final String name;
  final AutonomyLevel autonomyLevel;
  final String password;

  Dealership(
      {required this.cnpj,
      required this.name,
      required this.autonomyLevel,
      required this.password});
}
