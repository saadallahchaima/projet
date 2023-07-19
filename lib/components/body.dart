import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet/Profile.dart';
import 'package:projet/components/search_box.dart';
import 'dart:convert';

import '../constants.dart';
import '../models/User.dart';
import '../update_user.dart';

class Body extends StatefulWidget {
  final int index;

  const Body({Key? key, required this.index}) : super(key: key);

  static const routeName = '/serviceuser-screen';

  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {
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
          id: data['id'].toString(),
          isActive: data['isActive'] ?? true,
        );
      }).toList();
    } else {
      throw Exception('Erreur lors de la récupération des utilisateurs');
    }
  }
  Future<void> updateUser(User user) async {
    final url = 'http://192.168.1.15/projet_api/update_user.php';

    final response = await http.post(Uri.parse(url), body: {
      'id': user.id,
      'nom': user.nom,
      'email': user.email,
      'phone': user.phone,
      'cin': user.cin,
    });

    if (response.statusCode == 200) {
      // Mise à jour réussie
      setState(() {
        user.isActive = !user.isActive;
      });
    } else {
      throw Exception('Erreur lors de la mise à jour de l\'utilisateur');
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
                FutureBuilder<List<User>>(
                  future: getUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final user = snapshot.data![index];


                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding / 2,
                            ),
                            height: 160,
                            child: InkWell(
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
                                                builder: (context) => ProfileScreen(user: user),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => UpdateRecord(
                                                    user.nom,
                                                    user.email,
                                                    user.phone,
                                                    user.cin


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
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors de la récupération des utilisateurs');
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
    );
  }
}
