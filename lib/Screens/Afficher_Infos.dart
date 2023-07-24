import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ajouter_info.dart';

class CarInfoScreen extends StatefulWidget {
  static const routeName = '/carInfo-screen';

  final int userId;

  CarInfoScreen({required this.userId});

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  List<Voiture> userCars = [];

  @override
  void initState() {
    super.initState();
    // Call a function to fetch car information for the user based on the userId
    fetchUserCars();
  }

  Future<void> fetchUserCars() async {
    // Make an HTTP request to your backend API to get the car information for the user
    var url = Uri.parse("http://192.168.1.15/projet_api/afficher_infos.php?userId=${widget.userId}");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the response and convert it to a List<Voiture>
      var jsonData = json.decode(response.body);
      List<Voiture> cars = [];
      for (var carData in jsonData) {
        cars.add(Voiture(
          id: carData['id'],
          marque: CarBrand(name: carData['marque'], imageUrl: carData['imageUrl']),
          Modele: carData['Modele'],
          Kilometrage: carData['Kilometrage'],
          type_c: carData['type_c'],
        ));
      }

      // Update the state with the fetched car information
      setState(() {
        userCars = cars;
      });
    } else {
      // Handle the case when the HTTP request fails
      print("Failed to fetch user cars: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Information'),
      ),
      body: ListView.builder(
        itemCount: userCars.length,
        itemBuilder: (context, index) {
          var car = userCars[index];
          // Build the UI to display the car information for each car in the list
          return ListTile(
            leading: Image.network(car.marque!.imageUrl),
            title: Text(car.marque!.name),
            subtitle: Text('Model: ${car.Modele}, Kilometrage: ${car.Kilometrage}'),
            // Add more information as needed
          );
        },
      ),
    );
  }
}
