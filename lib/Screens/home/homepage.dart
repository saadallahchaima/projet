import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../UserListPage.dart';
import '/Screens/page_user.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
      routes: {

          // Autres routes...
          '/user-screen': (context) => page_utilisateur(),
        '/serviceuser-screen' :  (context) => page_utilisateur(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Home!',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Votre App',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white54,
                    ),
                  ),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(''),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard(
                    'Utilisateurs',
                    CupertinoIcons.person_2,
                    Colors.deepOrange,
                        () {
                      Navigator.of(context).pushNamed(page_utilisateur.routeName);
                    },
                  ),

                  itemDashboard(
                    'Cartes',
                    CupertinoIcons.creditcard,
                    Colors.green,
                        () {
                      Navigator.of(context).pushNamed(page_utilisateur.routeName);
                    },
                  ),
                  itemDashboard(
                    'Voitures',
                    CupertinoIcons.car,
                    Colors.purple,
                        () {
                      Navigator.of(context).pushNamed(page_utilisateur.routeName);
                    },
                  ),
                  itemDashboard(
                    'Chat',
                    CupertinoIcons.chat_bubble_2,
                    Colors.brown,
                        () {
                      Navigator.of(context).pushNamed(page_utilisateur.routeName);
                    },
                  ),
                  itemDashboard(
                    'Stat',
                    CupertinoIcons.graph_circle,
                    Colors.indigo,
                        () {
                      Navigator.of(context).pushNamed(page_utilisateur.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background, pressed) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }

}
