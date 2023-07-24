import 'package:flutter/material.dart';
import 'package:projet/models/User.dart';
import 'package:sizer/sizer.dart';
import 'Screens/Afficher_Infos.dart';
import 'Screens/ajouter_info.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/WelcomScreen.dart';

import 'Screens/pageuser.dart';
import 'entry_point.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this line

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,

          home: Bg(),
          routes: {
          Bg.routeName: (context) => Bg(),
       WelcomeScreen.routeName: (context) => WelcomeScreen(),
       SignupScreen.routeName: (context) => SignupScreen(),
       LoginScreen.routeName: (context) => LoginScreen(),
        EntryPoint.routeName: (context) => EntryPoint(),
        ListTest.routeName: (context) => ListTest(),

          },
        );
      },
    );
  }

  // Function to retrieve userId from SharedPreferences
  Future<int> _getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }
}