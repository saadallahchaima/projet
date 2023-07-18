class User {
  final String nom;
  final String email;
  final String phone;
  final String cin;
  final int? id;
  bool isActive;

  User({
    required this.nom,
    required this.email,
    required this.phone,
    required this.cin,
    this.id,
    this.isActive = true,
  });

  int? get userId => id;
}
