import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:projet/models/Class_carte.dart';

import '../models/Carburant.dart';
import '../models/User.dart';
import 'afficher_infos_formulaire.dart';
import 'login_screen.dart';


class ListTest extends StatefulWidget {
  ListTest({Key? key}) : super(key: key);

  static const routeName = '/ajouter_info-screen';

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<Carburant> _carConsumption =
  ValueNotifier<Carburant>(Carburant());

  @override
  State<ListTest> createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  Color gradientFirst = const Color(0xff0f17ad);
  Color gradientSecond = const Color(0xFF6985e8);
  Color secondPageTitleColor = const Color(0xFFfefeff);
  Color circuitsColor = const Color(0xFF2f2f51);

  @override
  void initState() {
    super.initState();
    widget._carConsumption.value.carte =
        Carte(); // Correction de l'initialisation de _carConsumption.value.carte
  }

  @override
  Widget build(BuildContext context) {
    String? finalEmail = Get.arguments as String?;

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
                        InkWell(
                          onTap: () {
                            // Code pour la navigation vers une autre page
                            // Utilisez Navigator pour naviguer vers une nouvelle page ou revenir en arrière
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: gradientSecond,
                          ),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: Column(
                      children: [

                        const SizedBox(
                          height: 140,
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
                                FormBuilderTextField(
                                  name: 'carte[num_carte]',
                                  decoration: const InputDecoration(
                                    labelText: 'Numéro de carte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) async {
                                    setState(() {
                                      int? numCarte = int.tryParse(value ?? '');
                                      double? plafon = double.tryParse(value ?? '');

                                      widget._carConsumption.value.carte =
                                          Carte(num_carte: numCarte, plafon: plafon);
                                    });


                                  },
                                ),
                                const SizedBox(height: 16.0),
                                FormBuilderTextField(
                                  name: 'user[nom]',
                                  decoration: const InputDecoration(
                                    labelText: 'user name',
                                  ),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      widget._carConsumption.value.user =
                                          User(
                                              nom: value ?? "",
                                              email: '',
                                              password: '',
                                              phone: '',
                                              cin: '');
                                    });
                                  },
                                  validator: FormBuilderValidators.required(
                                      errorText: 'Veuillez entrer votre nom'),
                                ),
                                FormBuilderTextField(
                                  name: 'Nombre de Litre',
                                  decoration: const InputDecoration(
                                    labelText: 'Nombre de litre',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      widget._carConsumption.value.nb_litres =
                                          double.tryParse(value!) ?? 0;
                                    });
                                  },
                                  validator: FormBuilderValidators.required(
                                      errorText: 'nombre de litre'),
                                ),
                                const SizedBox(height: 16.0),
                                FormBuilderTextField(
                                  name: '',
                                  decoration: const InputDecoration(
                                    labelText: 'Montant',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      int montant = int.tryParse(value ?? '') ?? 0;
                                      widget._carConsumption.value.montant =
                                          montant.toDouble();
                                      widget._carConsumption.value.calculateRest();
                                    });
                                  },
                                  validator: FormBuilderValidators.required(
                                      errorText: 'Veuillez entrer le montant'),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  widget._carConsumption.value.rest?.toStringAsFixed(2) ??
                                      '0.00',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16.0),
                                FormBuilderDateTimePicker(
                                  name: 'consumptionDate',
                                  inputType: InputType.date,
                                  format: DateFormat('yyyy-MM-dd'),
                                  decoration: const InputDecoration(
                                    labelText: 'Date de consommation',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      widget._carConsumption.value.date = value;
                                    });
                                  },
                                  validator: FormBuilderValidators.required(
                                      errorText: 'Veuillez sélectionner la date de consommation'),
                                ),
                                const SizedBox(height: 16.0),
                                GestureDetector(
                                  onTap: () {
                                    saveCarConsumptionDetails();
                                  },
                                  child: Container(
                                    width: 220,
                                    height: 64.32,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
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
    widget._carConsumption.value.calculateRest();

    Map<String, dynamic> formData = {
      'id_user': {'Nom': widget._carConsumption.value.user?.nom},
      'id_carte': {'num_carte': widget._carConsumption.value.carte?.num_carte},
      'montant': widget._carConsumption.value.montant,
      'rest': widget._carConsumption.value.rest,
      'nombre_litres': widget._carConsumption.value.nb_litres,
      'date': widget._carConsumption.value.date?.toIso8601String(),
    };

    print('formData: $formData');
    String jsonData = jsonEncode(formData);

    final url = 'http://192.168.1.11/projet_api/fuel_calss.php';
    final headers = {'Content-Type': 'application/json'};

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
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
        btnOkOnPress: () {
          // Navigate to the HistoriquePage after saving

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HistoriquePage( carburant: widget._carConsumption.value),
            ),
          );
        }
      ).show();
    } else {
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
