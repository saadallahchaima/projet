import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet/models/User.dart';
import 'dart:convert';
import '../models/Cars.dart';
import '../constants.dart';
import '../components/search_box.dart';
import 'Screens/DetailesCars.dart';
import 'Screens/ajouter_voiture.dart';
import 'models/fuelClass.dart';

class Cars extends StatefulWidget {
  static const routeName = '/cars-screen';

  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  final String apiUrl = 'http://192.168.1.11/projet_api/consommation.php';
  List<Voiture> cars = [];

  Future<List<Voiture>> chercherCar(String searchTerm) async {
    final String url = 'http://192.168.1.11/projet_api/search.php?search=$searchTerm';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) {

          return Voiture(
            id_v: data['id_v'].toString(),
            marque: data['marque'].toString(),
            model: data['Modele'].toString(),
            type_c: data['type_c'].toString(),
            kilometrage: data['Kilometrage'].toString(),
          );
        }).toList();
      } else {
        throw Exception('Erreur lors de la recherche de voitures');
      }
    } catch (e) {
      print('Error while fetching data: $e');
      throw Exception('Erreur lors de la recherche de voitures');
    }
  }

  Future<List<Voiture>> getCars() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) {



        // Create the Car object with the associated User object and fuel fill-ups
        return Voiture(
          id_v: data['id_v'].toString(),
          marque: data['marque'].toString(),
          model: data['Modele'].toString(),
          type_c: data['type_c'].toString(),
          kilometrage: data['Kilometrage'].toString(),
        );
      }).toList();
    } else {
      throw Exception('Erreur lors de la récupération des Voitures');
    }
  }


  @override
  void initState() {
    super.initState();

    getCars().then((data) {
      setState(() {
        cars = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarWithAddIcon(),
    body: SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[

          const SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                FutureBuilder<List<Voiture>>(
                  future: getCars(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final car = snapshot.data![index]; // Change 'Voiture' to 'car'
                          //print("Nom de l'utilisateur associé: ${car.user.nom}");

                          print('Voiture ID: ${car.id_v}');


                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding / 2,
                            ),
                            height: 160,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailCars(car: car),
                                  ),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  Container(
                                    height: 136,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: index.isEven ? kBlueColor : kSecondaryColor,
                                      boxShadow: const [kDefaultShadow],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Spacer(),
                                            Padding(

                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                "Marque: ${car.marque}",
                                                style: Theme.of(context).textTheme.titleLarge,
                                              ),
                                            ),
                                           // Padding(
                                            //  padding: const EdgeInsets.symmetric(horizontal: 20),
                                            //  child: Text(
                                            //    "Modele: ${car.model}",
                                            //    style: Theme.of(context).textTheme.bodyMedium,
                                            //  ),
                                           // ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                " Modele: ${car.model}",
                                                style: Theme.of(context).textTheme.bodyMedium,
                                                softWrap: false, // Empêche le texte de se retourner automatiquement
                                              ),
                                            ),

                                            const Spacer(),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: kDefaultPadding * 1.5,
                                                vertical: kDefaultPadding / 4,
                                              ),
                                              decoration: const BoxDecoration(
                                                color: kSecondaryColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(22),
                                                  topLeft: Radius.circular(22),
                                                ),
                                              ),
                                              child: Text(
                                                " Carburants: ${car.type_c}",
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: kDefaultPadding),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                        height: 110,
                                        width: 210,
                                        child: Image.asset(
                                          "images/hun.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Row(
                                      children: <Widget>[

                                      ],

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors de la récupération des voitures');
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
  AppBar _buildAppBarWithAddIcon() {
    return AppBar(
      backgroundColor: Color(0xFF092562), // Blue color
      title: Text(
        "Liste des cartes",
        style: TextStyle(color: Colors.white), // Set the text color to white
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 24.0),
          alignment: Alignment.center,
          child: FloatingActionButton(
            elevation: 2.0,
            onPressed: () {
      Navigator.push(
          context,
      MaterialPageRoute(builder: (context) => Ajouter_voiture()),
         );
            },
            backgroundColor: Color(0xFF00030A),
            mini: false,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}