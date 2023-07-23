import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Voiture());
}

class CarBrand {
  String name;
  String imageUrl;

  CarBrand({required this.name, required this.imageUrl});
}

class CarConsumption {
  CarBrand? brand;
  double? mileage;
  String? fuelType;
  DateTime? consumptionDate;
  double? fuelPrice;
}

class Voiture extends StatefulWidget {
  @override
  State<Voiture> createState() => _VoitureState();
}

class _VoitureState extends State<Voiture> {
  final List<CarBrand> carBrands = [
    CarBrand(name: 'Volvo', imageUrl: 'data:image/png;base64,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'),
    CarBrand(name: 'Toyota', imageUrl: 'https://example.com/toyota_logo.png'),
    CarBrand(name: 'Honda', imageUrl: 'https://example.com/honda_logo.png'),
    CarBrand(name: 'Ford', imageUrl: 'https://example.com/ford_logo.png'),
    CarBrand(name: 'Chevrolet', imageUrl: 'https://example.com/chevrolet_logo.png'),
  ];

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<CarConsumption> _carConsumption = ValueNotifier<CarConsumption>(CarConsumption());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Car Consumption App'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDropdown<CarBrand>(
                  name: 'carBrand',
                  decoration: InputDecoration(labelText: 'Marque de voiture'),
                  items: carBrands.map((brand) => DropdownMenuItem<CarBrand>(
                    value: brand,
                    child: Row(
                      children: [
                        Image.network(
                          brand.imageUrl,
                          width: 24,
                          height: 24,
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
                      _carConsumption.value.brand = value;
                    });
                  },
                  validator: FormBuilderValidators.required(errorText: 'Veuillez sélectionner une marque de voiture'),
                ),

                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'mileage',
                  decoration: InputDecoration(labelText: 'Kilométrage'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _carConsumption.value.mileage = double.tryParse(value!) ?? 0;
                    });
                  },
                  validator: FormBuilderValidators.required(errorText: 'Veuillez entrer le kilométrage'),
                ),
                SizedBox(height: 16.0),
                FormBuilderDropdown(
                  name: 'fuelType',
                  decoration: InputDecoration(labelText: 'Type de carburant'),
                  items: ['Essence', 'Gasoil'].map((type) => DropdownMenuItem<String>(value: type, child: Text(type))).toList(),
                  onChanged: (value) {
                    setState(() {
                      _carConsumption.value.fuelType = value.toString();
                    });
                  },
                  validator: FormBuilderValidators.required(errorText: 'Veuillez sélectionner le type de carburant'),
                ),
                SizedBox(height: 16.0),
                FormBuilderDateTimePicker(
                  name: 'consumptionDate',
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                  decoration: InputDecoration(labelText: 'Date de consommation'),
                  onChanged: (value) {
                    setState(() {
                      _carConsumption.value.consumptionDate = value;
                    });
                  },
                  validator: FormBuilderValidators.required(errorText: 'Veuillez sélectionner la date de consommation'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      // Access the form data using _formKey.currentState!.value
                      // For example, to access the brand name: _formKey.currentState!.value['carBrand']?.name
                      print('Car consumption details saved!');
                      print('Brand: ${_carConsumption.value.brand?.name}');
                      print('Mileage: ${_carConsumption.value.mileage}');
                      print('Fuel Type: ${_carConsumption.value.fuelType}');
                      print('Consumption Date: ${_carConsumption.value.consumptionDate}');
                    }
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
