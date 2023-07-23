import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import 'Screens/CarBrand brand.dart';

class CarConsumption {
  CarBrand? brand;
  double? mileage;
  String? fuelType;
  DateTime? consumptionDate;
  double? fuelPrice;
}

class ListTest extends StatefulWidget {
  final List<CarBrand> carBrands = [
    CarBrand(name: 'Volvo', imageUrl: 'https://www.volvocars.com/images/v/-/media/market-assets/switzerland/applications/local-pages/blog/update-mai/volvo_logo_1920x1440.jpg?iar=0&w=720'),
    CarBrand(name: 'Toyota', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Toyota_EU.svg/langfr-1280px-Toyota_EU.svg.png'),
    CarBrand(name: 'Honda', imageUrl: 'https://www.1min30.com/wp-content/uploads/2017/09/Honda-logo-500x154.jpg'),
    CarBrand(name: 'Ford', imageUrl: 'https://www.carlogos.org/car-logos/ford-logo-2017-640.png'),
    CarBrand(name: 'Hyundai', imageUrl: 'https://www.1min30.com/wp-content/uploads/2019/02/Embl%C3%A8me-Hyundai-500x281.jpg'),
  ];

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<CarConsumption> _carConsumption = ValueNotifier<CarConsumption>(CarConsumption());

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
                  SizedBox(height: 30),
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90, // Increase this value to add more white space
                    ),
                    Row(
                      children: [
                        SizedBox(width: 30),
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
                      padding: EdgeInsets.all(16.0),
                      child: FormBuilder(
                        key: widget._formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormBuilderDropdown<CarBrand>(
                              name: 'carBrand',
                              decoration: InputDecoration(labelText: 'Marque de voiture'),
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
                                        return CircularProgressIndicator();
                                      },
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                    ),
                                    SizedBox(width: 8),
                                    Text(brand.name),
                                  ],
                                ),
                              )).toList(),
                              onChanged: (CarBrand? value) {
                                setState(() {
                                  widget._carConsumption.value.brand = value;
                                });
                              },
                              validator: FormBuilderValidators.required(errorText: 'Veuillez sélectionner une marque de voiture'),
                            ),

                            SizedBox(height: 16.0),
                            FormBuilderTextField(
                              name: 'mileage',
                              decoration: InputDecoration(
                                  labelText: 'Kilométrage'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  widget._carConsumption.value.mileage =
                                      double.tryParse(value!) ?? 0;
                                });
                              },
                              validator: FormBuilderValidators.required(
                                  errorText: 'Veuillez entrer le kilométrage'),
                            ),
                            SizedBox(height: 16.0),
                            FormBuilderDropdown(
                              name: 'fuelType',
                              decoration: InputDecoration(
                                  labelText: 'Type de carburant'),
                              items: ['Essence', 'Gasoil'].map((type) =>
                                  DropdownMenuItem<String>(
                                      value: type, child: Text(type))).toList(),
                              onChanged: (value) {
                                setState(() {
                                  widget._carConsumption.value.fuelType =
                                      value.toString();
                                });
                              },
                              validator: FormBuilderValidators.required(
                                  errorText: 'Veuillez sélectionner le type de carburant'),
                            ),
                            SizedBox(height: 16.0),
                            FormBuilderDateTimePicker(
                              name: 'consumptionDate',
                              inputType: InputType.date,
                              format: DateFormat('yyyy-MM-dd'),
                              decoration: InputDecoration(
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
                            SizedBox(height: 16.0),
                            GestureDetector(
                              onTap: () {
                                if (widget._formKey.currentState!.saveAndValidate()) {
                                  // Access the form data using widget._formKey.currentState!.value
                                  // For example, to access the brand name: widget._formKey.currentState!.value['carBrand']?.name
                                  print('Car consumption details saved!');
                                  print('Brand: ${widget._carConsumption.value.brand?.name}');
                                  print('Mileage: ${widget._carConsumption.value.mileage}');
                                  print('Fuel Type: ${widget._carConsumption.value.fuelType}');
                                  print('Consumption Date: ${widget._carConsumption.value.consumptionDate}');
                                }
                              },
                              child: Container(
                                width: 220,
                                height: 64.32,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF136AF3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.98),
                                  ),
                                ),
                                child: Row(
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
          ],
        ),
      ),
    );
  }
}
