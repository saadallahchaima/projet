class User {
  String nom;
  String email;
  String phone;
  String cin;
  String id;
  bool isActive;

  User({
    required this.nom,
    required this.email,
    required this.phone,
    required this.cin,
    required this.id,
    this.isActive = true,
  });
}

