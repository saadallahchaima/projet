import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class Cart {
  final String num_cart;
  final String kiosque;
  final DateTime date;
  final String plafont;

  Cart({
    required this.num_cart,
    required this.kiosque,
    required this.date,
    required this.plafont,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      num_cart: json['num_carte'] ?? '',
      kiosque: json['kiosque'] ?? '',
      date: json['date_creation'] != null ? DateTime.tryParse(json['date_creation']) ?? DateTime(2000) : DateTime(2000),
      plafont: json['plafon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num_carte': num_cart,
      'kiosque': kiosque,
      'date': date.toIso8601String(),
      'plafon': plafont,
    };
  }
}

class Carts extends StatefulWidget {
  static const routeName = '/cart-page';

  const Carts({super.key});

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  final String apiUrl = 'http://192.168.1.11/projet_api/';
  List<Cart> carts = [];

  @override
  void initState() {
    super.initState();
    _fetchCartsData();
  }

  Future<void> _fetchCartsData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/carts.php'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          carts = jsonData.map((json) => Cart.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load carts');
      }
    } catch (error) {
      throw Exception('Failed to load carts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarWithAddIcon(),

      backgroundColor: Colors.black, // Set the background color of the entire surface to black
      extendBody: true, // Make the body take up the entire surface, including the area behind the AppBar
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              ...carts.map((cartItem) => _buildCreditCard(
                color: Color.fromARGB(255, 104, 5, 232),
                cardExpiration: cartItem.date.toString(),
                cardHolder: cartItem.kiosque,
                cardNumber: cartItem.num_cart,
                cardplafon: cartItem.plafont,
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCartPage()),
          );
        },
        backgroundColor: Color(0xFF081603),
        mini: false,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBarWithAddIcon() {
    return AppBar(
      backgroundColor: Color(0xFF081603),
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
                MaterialPageRoute(builder: (context) => AddCartPage()),
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

// ... rest of the code ...
}



Card _buildCreditCard({
  required Color color,
  required String cardNumber,
  required String cardHolder,
  required String cardExpiration,
  required String cardplafon,
}) {
  return Card(
    elevation: 4.0,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    child: Container(
      height: 200,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildLogosBlock(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              '$cardNumber',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'CourierPrime',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildDetailsBlock(
                label: 'carburant',
                value: cardHolder,
              ),
              _buildDetailsBlock(label: 'DATE', value: cardExpiration),
              _buildDetailsBlock(label: 'Plafon', value: cardplafon),
            ],
          ),
        ],
      ),
    ),
  );
}

Row _buildLogosBlock() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Image.asset(
        "assets/images/contact_less.png",
        height: 20,
        width: 18,
      ),
      Image.asset(
        "assets/images/mastercard.png",
        height: 50,
        width: 50,
      ),
    ],
  );
}

Column _buildDetailsBlock({required String label, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        '$label',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        '$value',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}


class AddCartPage extends StatefulWidget {
  @override
  _AddCartPageState createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numCartController = TextEditingController();
  final TextEditingController _kiosqueController = TextEditingController();
  DateTime? _selectedDate;
  final TextEditingController _plafontController = TextEditingController();

  void _addCart() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://192.168.1.11/projet_api/ajout_cart.php'; // Remplacez par l'URL de votre fichier PHP
      final response = await http.post(
        Uri.parse(url),
        body: {
          'num_carte': _numCartController.text,
          'kiosque': _kiosqueController.text,
          'date_creation': _selectedDate.toString(),
          'plafon': _plafontController.text,
        },
      );


      if (response.statusCode == 200) {
        print('Cart ajoutée avec succès: ${response.body}');
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.TOPSLIDE,
            showCloseIcon: true,
            title: "Saved",
            desc: "Saved",
            btnOkOnPress: () {
              // Navigate to the HistoriquePage after saving

            }
        ).show();
        // Afficher un message de succès à l'utilisateur ou rediriger vers une autre page si nécessaire
      } else {
        print('Erreur lors de l\'ajout de la Cart : ${response.body}');
        // Afficher un message d'erreur à l'utilisateur en cas d'échec
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Cart'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numCartController,
                decoration: InputDecoration(labelText: 'Numéro de carte'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le numéro de carte';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kiosqueController,
                decoration: InputDecoration(labelText: 'Nom du Kiosque'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le nom du kiosque';
                  }
                  return null;
                },
              ),
              FormBuilderDateTimePicker(
                name: 'date',
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                decoration: const InputDecoration(
                  labelText: 'Date de consommation',
                ),
                onChanged: (value) {
                  // Update the selected date when the value changes
                  setState(() {
                    _selectedDate = value; // Change this line
                  });
                },
                validator: FormBuilderValidators.required(
                  errorText: 'Veuillez sélectionner la date de consommation',
                )
              ),
              TextFormField(
                controller: _plafontController,
                decoration: InputDecoration(labelText: 'Plafond'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le plafond';
                  }
                  // Vous pouvez ajouter une validation supplémentaire pour le format du plafond si nécessaire
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addCart,
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: Carts(),
  ));
}