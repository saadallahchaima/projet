import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../models/Cars.dart';



class Ajouter_voiture extends StatefulWidget {
  static const routeName = '/ajouter_info-screen';
  Ajouter_voiture({Key? key}) : super(key: key);



  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<Voiture> _carConsumption = ValueNotifier<Voiture>(
    Voiture(
      id_v: '0', // You can assign any default value for id_v, e.g., '0'
      marque: '',
      model: '',
      type_c: '',
      kilometrage: '0', // You can assign any default value for kilometrage, e.g., '0'
    ),
  );
  final List<Voiture> voitures = [];


  @override
  State<Ajouter_voiture> createState() => _Ajouter_voitureState();
}

class _Ajouter_voitureState extends State<Ajouter_voiture> {
  Color gradientFirst = const Color(0xff0f17ad);
  Color gradientSecond = const Color(0xFF6985e8);
  Color secondPageTitleColor = const Color(0xFFfefeff);
  Color circuitsColor = const Color(0xFF2f2f51);
  @override
  void initState() {
    super.initState();
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
                padding: const EdgeInsets.all(70),

                width: MediaQuery.of(context).size.width,
                height: 100,
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

                                const SizedBox(height: 16.0),
                                FormBuilderTextField(
                                  name: 'Kilometrage',
                                  decoration: const InputDecoration(
                                    labelText: 'Kilometrage',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      widget._carConsumption.value.kilometrage = value!;
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
                                      widget._carConsumption.value.model= value!;
                                    });
                                  },
                                  validator: FormBuilderValidators.required(errorText: 'Veuillez entrer la marque de votre voiture'),
                                ),
                                const SizedBox(height: 16.0),
                                FormBuilderTextField(
                                  name: 'Modele',
                                  decoration: const InputDecoration(
                                    labelText: 'Modele de votre voiture',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      widget._carConsumption.value.marque= value!;
                                    });
                                  },
                                  validator: FormBuilderValidators.required(errorText: 'Veuillez entrer la marque de votre voiture'),
                                ),
                                const SizedBox(height: 16.0),
                                FormBuilderDropdown(
                                  name: 'type_c',
                                  decoration: const InputDecoration(
                                    labelText: 'Type de carburant',
                                  ),
                                  items: ['Essence', 'Gasoil'].map((type) =>
                                      DropdownMenuItem<String>(
                                          value: type, child: Text(type))).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      widget._carConsumption.value.type_c = value.toString();
                                    });
                                  },
                                  validator: FormBuilderValidators.required(
                                      errorText: 'Veuillez sélectionner le type de carburant'),
                                ),

                                const SizedBox(height: 16.0),
                                GestureDetector(
                                  onTap: ()  {

                                    saveCarConsumptionDetails();
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
          ),
        ),
      ),
    );
  }

  Future<void> saveCarConsumptionDetails() async {


    Map<String, dynamic> formData = {
      'marque': widget._carConsumption.value.marque,
      'Modele': widget._carConsumption.value.model,
      'Kilometrage': widget._carConsumption.value.kilometrage,
      'type_c': widget._carConsumption.value.type_c,
    };



    String jsonData = jsonEncode(formData);

    var url = 'http://192.168.1.11/projet_api/ajouter_voiture.php';
    var response = await http.post(
      Uri.parse(url),
      body: jsonData,
    );


    if (response.statusCode == 200) {
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
    }
    else {
      print('Failed to save car consumption details.');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        title: "Error",
        desc: "Failed to save car consumption details.",
        btnCancelOnPress: () {},
      ).show();
      print('Response: ${response.body}');
    }
  }
}