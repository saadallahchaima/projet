import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class UserListPage extends StatefulWidget {

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late FixedExtentScrollController controller;

  final String apiUrl = 'http://192.168.137.163/projet_api/user.php';
  List<String> users = [];

  Future<void> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        users = jsonData.map((data) => data['nom'].toString()).toList();
      });
    } else {
      throw Exception('Erreur lors de la récupération des utilisateurs');
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers();
    controller = FixedExtentScrollController();

  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller
    super.dispose();
  }

  Widget buildCard(int index) {
    final String userName = users[index];
    return Center(
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 300.0,
        height: 400.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            userName,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des utilisateurs'),
        centerTitle:  true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          final nextIndex = controller.selectedItem + 1;
          controller.animateToItem(
            nextIndex,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListWheelScrollView(
        itemExtent: 250,
        physics: FixedExtentScrollPhysics(),
        controller: controller, // Set the controller
        perspective: 0.005,
        diameterRatio: 6,
        onSelectedItemChanged: (index) => Fluttertoast.showToast(
          msg: 'Selected Item: ${index + 1}',
          toastLength: Toast.LENGTH_SHORT,
        ),
        children: List.generate(
          users.length,
              (index) => buildCard(index),
        ),
      ),
    );
  }
}
