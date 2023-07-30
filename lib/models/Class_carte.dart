class Carte {
  int? id_carte;
  int? num_carte;
  String? kiosque;
  double? plafon;
  DateTime? date_creation;

  Carte({
    this.id_carte,
    this.num_carte,
    this.kiosque,
    this.plafon,
    this.date_creation,
  });

  factory Carte.fromJson(Map<String, dynamic> json) {
    return Carte(
      id_carte: json['id_carte'],
      num_carte: json['num_carte'],
      kiosque: json['kiosque'],
      plafon: json['plafon'],
      date_creation: json['date_creation'] != null
          ? DateTime.parse(json['date_creation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_carte': id_carte,
      'num_carte': num_carte,
      'kiosque': kiosque,
      'plafon': plafon,
      'date_creation': date_creation?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Carte(id_carte: $id_carte, num_carte: $num_carte, kiosque: $kiosque, plafon: $plafon, date_creation: $date_creation)';
  }
}