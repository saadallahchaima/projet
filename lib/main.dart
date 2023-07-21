import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'Listetest.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/WelcomScreen.dart';

import 'entry_point.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


String username='';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,

          home: EntryPoint(),
          routes: {
            Bg.routeName: (context) => Bg(),
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            SignupScreen.routeName: (context) => SignupScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
           EntryPoint.routeName: (context) => EntryPoint(),
          },
        );
      },
    );
  }

}

