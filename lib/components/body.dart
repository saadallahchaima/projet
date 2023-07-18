import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet/Profile.dart';
import 'package:projet/components/search_box.dart';
import 'dart:convert';

import '../Screens/detail_user.dart';
import '../constants.dart';
import '../models/User.dart';

class Body extends StatefulWidget {
  final int index;

  const Body({Key? key, required this.index}) : super(key: key);

  static const routeName = '/serviceuser-screen';

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<void> deleteUser(int? userID) async {
    if (userID == null) {
      return;
    }

    try {
      var response = await http.get(Uri.parse('http://192.168.1.15/projet_api/delete_user.php?id_user=$userID'));

      if (response.statusCode == 200) {
        print('L\'utilisateur a été supprimé avec succès.');
        setState(() {
          users.removeWhere((user) => user.userId == userID);
        });
      } else {
        print('Une erreur s\'est produite lors de la suppression de l\'utilisateur.');
        print('Code d\'erreur: ${response.statusCode}');
      }
    } catch (error) {
      print('Une erreur s\'est produite lors de la suppression de l\'utilisateur : $error');
    }
  }

  final String apiUrl = 'http://192.168.1.15/projet_api/user.php';
  List<User> users = [];





  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) {
        return User(
          nom: data['nom'].toString(),
          email: data['email'].toString(),
          phone: data['phone'].toString(),
          cin: data['cin'].toString(),
          id: data['id'],
          isActive: data['isActive'] ?? true,
        );
      }).toList();
    } else {
      throw Exception('Erreur lors de la récupération des utilisateurs');
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers().then((data) {
      setState(() {
        users = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(
            onChanged: (value) {},
          ),
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
                ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
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
                              builder: (context) => DetailUser(user: user),
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
                                          "Nom: ${user.nom}",
                                          style: Theme.of(context).textTheme.labelLarge,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(
                                          "Email: ${user.email}",
                                          style: Theme.of(context).textTheme.labelLarge,
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
                                          "Numero de carte: ${user.cin}",
                                          style: Theme.of(context).textTheme.labelLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: kDefaultPadding),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                  height: 110,
                                  width: 150,
                                  child: Image.asset(
                                    "images/profile.png",
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
                                  IconButton(
                                    icon: const Icon(Icons.remove_red_eye_sharp),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                         // builder: (context) => UserEditPage(user: user),
                                          builder: (context) => ProfileScreen(user: user),

                                        ),
                                      );
                                    },
                                  ),



                                  IconButton(
                                    icon: Icon(user.isActive ? Icons.check_circle : Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        user.isActive = !user.isActive;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      deleteUser(user.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
