// Constructor for Dealership object
class Dealership {
  final int? id;
  final int cnpj;
  final String name;
  final int autonomyLevelId;
  final String password;
  final bool isActive;

  Dealership({
    this.id,
    required this.cnpj,
    required this.name,
    required this.autonomyLevelId,
    required this.password,
    required this.isActive,
  });

  @override
  String toString() {
    return name;
  }
}
