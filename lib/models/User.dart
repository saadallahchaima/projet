class User {
  int? id; // Make 'id' field nullable
  String nom;
  String email;
  String password;
  String phone;
  String cin;

  User({
    this.id, // Update the constructor to accept nullable id
    required this.nom,
    required this.email,
    required this.password,
    required this.phone,
    required this.cin,
  });
}
