import 'User.dart';
import 'fuelClass.dart';

class Voiture {
  final String id_v;
  final User user; // Add the User object here instead of id_user
  final String marque;
  final String model;
  final String type_c;
  String? imageURL; // Change imageURL to nullable since it will be set after upload
  final String kilometrage;
  List<FuelFillup> fuelFillups;


  Voiture({
    required this.id_v,
    required this.user,
    required this.marque,
    required this.model,
    required this.type_c,
    this.imageURL,
    required this.kilometrage,
    required this.fuelFillups,

  });}