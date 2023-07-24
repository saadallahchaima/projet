import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CarBrand {
  String name;
  String imageUrl;

  CarBrand({
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}

class Voiture {
  int? id;
  int? id_user;
  CarBrand? marque;
  String? Modele;
  double? Kilometrage;
  String? type_c;
  DateTime? consumptionDate;
  Voiture({
    this.id,
    this.id_user, // Add this field

    this.marque,
    this.Modele,
    this.Kilometrage,
    this.type_c,
  });

}



class ListTest extends StatefulWidget {
  static const routeName = '/ajouter_info-screen';

  final List<CarBrand> carBrands = [
    CarBrand(name: 'Volvo', imageUrl: 'https://www.volvocars.com/images/v/-/media/market-assets/switzerland/applications/local-pages/blog/update-mai/volvo_logo_1920x1440.jpg?iar=0&w=720'),
    CarBrand(name: 'Toyota', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Toyota_EU.svg/langfr-1280px-Toyota_EU.svg.png'),
    CarBrand(name: 'Honda', imageUrl: 'https://www.1min30.com/wp-content/uploads/2017/09/Honda-logo-500x154.jpg'),
    CarBrand(name: 'Ford', imageUrl: 'https://www.carlogos.org/car-logos/ford-logo-2017-640.png'),
    CarBrand(name: 'Hyundai', imageUrl: 'https://www.1min30.com/wp-content/uploads/2019/02/Embl%C3%A8me-Hyundai-500x281.jpg'),
  ];

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<Voiture> _carConsumption = ValueNotifier<Voiture>(Voiture());
  final List<Voiture> voitures = [];

  ListTest({Key? key}) : super(key: key);

  @override
  State<ListTest> createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  getRecord() async {
    // Your logic to retrieve records
  }

  @override
  void initState() {
    getRecord();
    super.initState();
  }

  Color gradientFirst = const Color(0xff0f17ad);
  Color gradientSecond = const Color(0xFF6985e8);
  Color secondPageTitleColor = const Color(0xFFfefeff);
  Color circuitsColor = const Color(0xFF2f2f51);
  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientFirst.withOpacity(0.9),
              gradientSecond,
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: gradientSecond,
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: gradientSecond,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Car Consumption App",
                      style: TextStyle(
                        fontSize: 20, // Increase the font size here
                        fontWeight: FontWeight.bold, // Use a bolder font weight
                        color: secondPageTitleColor,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(

                child: SingleChildScrollView(

                child: Container(

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                     topRight: Radius.circular(70)),
                        //Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 140, // Increase this value to add more white space
                      ),


                      Row(

                        children: [

                          const SizedBox(width: 30),

                          Text(

                            "Ajouter Vos infos",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: circuitsColor,
                            ),

                          ),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FormBuilder(
                          key: widget._formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormBuilderDropdown<CarBrand>(
                                name: 'marque',
                                decoration: const InputDecoration(labelText: 'Marque de voiture'),
                                items: widget.carBrands.map((brand) => DropdownMenuItem<CarBrand>(
                                  value: brand,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        brand.imageUrl,
                                        width: 50,
                                        height: 50,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return const CircularProgressIndicator();
                                        },
                                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(brand.name),
                                    ],
                                  ),
                                )).toList(),
                                onChanged: (CarBrand? value) {
                                  setState(() {
                                    // Utilisez la liste déroulante pour enregistrer la marque sélectionnée
                                    widget._carConsumption.value.marque = value;
                                  });
                                },
                                validator: FormBuilderValidators.required(errorText: 'Veuillez sélectionner une marque de voiture'),
                              ),

                              const SizedBox(height: 16.0),
                              FormBuilderTextField(
                                name: 'Kilometrage',
                                decoration: const InputDecoration(
                                  labelText: 'Kilometrage',
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    widget._carConsumption.value.Kilometrage = double.tryParse(value!) ?? 0;
                                  });
                                },
                                validator: FormBuilderValidators.required(errorText: 'Veuillez entrer le kilométrage de votre voiture'),
                              ),

                              const SizedBox(height: 16.0),
                              FormBuilderTextField(
                                name: 'Modele',
                                decoration: const InputDecoration(
                                  labelText: 'Marque de votre voiture',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    widget._carConsumption.value.Modele = value;
                                  });
                                },
                                validator: FormBuilderValidators.required(errorText: 'Veuillez entrer la marque de votre voiture'),
                              ),


                              const SizedBox(height: 16.0),
                              FormBuilderDropdown(
                                name: 'type_c',
                                decoration: const InputDecoration(
                                    labelText: 'Type de carburant'),
                                items: ['Essence', 'Gasoil'].map((type) =>
                                    DropdownMenuItem<String>(
                                        value: type, child: Text(type))).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    widget._carConsumption.value.	type_c =
                                        value.toString();
                                  });
                                },
                                validator: FormBuilderValidators.required(
                                    errorText: 'Veuillez sélectionner le type de carburant'),

                              ),

                              const SizedBox(height: 16.0),
                              FormBuilderDateTimePicker(
                                name: 'consumptionDate',
                                inputType: InputType.date,
                                format: DateFormat('yyyy-MM-dd'),
                                decoration: const InputDecoration(
                                    labelText: 'Date de consommation'),
                                onChanged: (value) {
                                  setState(() {
                                    widget._carConsumption.value.consumptionDate =
                                        value;
                                  });
                                },
                                validator: FormBuilderValidators.required(
                                    errorText: 'Veuillez sélectionner la date de consommation'),

                              ),

                              const SizedBox(height: 16.0),
                              GestureDetector(
                                onTap: () async {
                                  if (widget._formKey.currentState!.saveAndValidate()) {
                                    // Convert the form data to a JSON map
                                    Map<String, dynamic> formData = {

                                      'marque': widget._carConsumption.value.marque?.toJson(),
                                      'Modele': widget._carConsumption.value.Modele,
                                      'Kilometrage': widget._carConsumption.value.Kilometrage,
                                      'type_c': widget._carConsumption.value.type_c,
                                      'consumptionDate': widget._carConsumption.value.consumptionDate?.toIso8601String(),
                                    };
                                    String jsonData = jsonEncode(formData);
                                    int? userId = await getUserId();
                                    // Envoyer les données au serveur PHP
                                    var url = 'http://192.168.137.163/projet_api/ajouter_infos.php'; // Remove the space before the IP address
                                    var headers = {
                                      'Content-Type': 'application/json'
                                    };
                                    var response = await http.post(
                                      Uri.parse(url),
                                      headers: headers,
                                      body: jsonData,
                                    );

                                    // Vérifier la réponse du serveur
                                    if (response.statusCode == 200) {
                                      // Les données ont été insérées avec succès dans la base de données
                                      print('Car consumption details saved!');
                                      print('Response: ${response.body}');
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.TOPSLIDE,
                                        showCloseIcon: true,
                                        title: "Saved",
                                        desc: "Saved",
                                        btnOkOnPress: () {},
                                      ).show();
                                      // Vous pouvez également afficher un message de succès à l'utilisateur ici
                                    } else {
    // Il y a eu une erreur lors de l'ajout des données
    print('Failed to save car consumption details.');
    print('Response: ${response.body}');


                                      // Vous pouvez également afficher un message d'erreur à l'utilisateur ici
                                    }
                                  }
                                },
                                child: Container(
                                  width: 220,
                                  height: 64.32,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF136AF3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.98),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Enregistrer',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.35,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
            ],
              )
          ),
        ),

    );
  }
}
