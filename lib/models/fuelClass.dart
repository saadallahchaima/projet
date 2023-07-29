class FuelFillup {
  final int id; // Unique ID for the fuel fill-up
  final DateTime date; // Date of the fuel fill-up
  final double numberOfLiters;
  final double prix;// Number of liters filled

  FuelFillup( {
    required this.id,
    required this.date,
    required this.numberOfLiters,
    required this.prix,
  });
}
