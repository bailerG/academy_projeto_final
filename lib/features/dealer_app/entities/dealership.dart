// Each Dealership should have it's own level of autonomy included here
enum AutonomyLevel { starter, intermediate, advanced, special }

// This class deefines what information is needed for a dealership to be registered
class Dealership {
  final int cnpj;
  final String name;
  final AutonomyLevel level;
  final String password;

  Dealership(this.cnpj, this.name, this.level, this.password);
}
