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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Add id field if present in JSON
      nom: json['nom'],
      email: json['email'], // Update the property name here if needed
      password: json['password'], // Update the property name here if needed
      phone: json['phone'], // Update the property name here if needed
      cin: json['cin'], // Update the property name here if needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Add id field if needed
      'nom': nom,
      'email': email, // Update the property name here if needed
      'password': password, // Update the property name here if needed
      'phone': phone, // Update the property name here if needed
      'cin': cin, // Update the property name here if needed
    };
  }
}
