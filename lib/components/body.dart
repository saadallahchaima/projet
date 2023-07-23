import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';
import '../models/User.dart';
import '../update_user.dart';

import '../Profile.dart';
import '../components/search_box.dart';

class Body extends StatefulWidget {
  final int index;

  const Body({Key? key, required this.index}) : super(key: key);

  static const routeName = '/serviceuser-screen';

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final String apiUrl = 'http://192.168.1.156/projet_api/user.php';
  List<User> users = [];

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) {
        return User(
          id: data['id_user'] != null ? int.parse(data['id_user'].toString()) : null,
          nom: data['nom'].toString(),
          email: data['email'].toString(),
          password: data['password'].toString(),
          phone: data['phone'].toString(),
          cin: data['cin'].toString(),
        );
      }).toList();
    } else {
      throw Exception('Erreur lors de la récupération des utilisateurs');
    }
  }

  Future<void> deleteUser(int? id) async {
    if (id == null) {
      // If the id is null, return without performing the delete operation
      return;
    }

    print('Deleting user with ID: $id');

    final url = 'http://192.168.1.156/projet_api/delete_user.php?id_user=$id';

    final response = await http.delete(Uri.parse(url), body: {
      'id_user': id.toString(),
    });

    if (response.statusCode == 200) {
      print('User with ID $id deleted successfully');
      setState(() {
        // Update the users list after deletion
        users = users.where((user) => user.id != id).toList();
      });
    } else {
      print('Error deleting user with ID $id');
      throw Exception('Erreur lors de la suppression de l\'utilisateur');
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

                          print('User ID: ${user.id}');
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
                                                style: Theme.of(context).textTheme.titleLarge,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                "Email: ${user.email}",
                                                style: Theme.of(context).textTheme.bodyText2,
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
                                                  user.cin,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text('Supprimer l\'utilisateur'),
                                                content: const Text('Êtes-vous sûr de vouloir supprimer cet utilisateur ?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: const Text('Annuler'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteUser(user.id); // Call deleteUser to perform the deletion
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: const Text('Supprimer'),
                                                  ),
                                                ],
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
