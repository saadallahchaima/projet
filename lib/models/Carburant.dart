import 'Class_carte.dart';
import 'User.dart';

class Carburant {
  int? id_c;
  double? nb_litres;
  Carte? carte;
  double? montant;
  double? rest;
  DateTime? date;
  User? user;

  Carburant({
    this.id_c,
    this.nb_litres,
    this.carte,
    this.montant,
    this.rest,
    this.date,
    this.user,
  });

  void calculateRest() {
    print("Carte: ${carte?.toJson()}");
    print("Montant: $montant");
    print("Plafon: ${carte?.plafon}");


    if (carte != null && montant != null && carte!.plafon != null) {
      rest = carte!.plafon! - montant!;
    } else {
      rest = null;
    }

    print("Plafon after update: ${carte?.plafon}");
    print("Rest: $rest");
  }

}