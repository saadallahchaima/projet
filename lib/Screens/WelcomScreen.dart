import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60, left: 25),
              child: Column(
                children: [

                  Text(
                    'HELLO',
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  Text(
                    'Carburants',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.indigo),
                  ),
                  SizedBox(height: 20), // Espacement vertical

                  Image.network(
                    'https://img.freepik.com/vecteurs-libre/illustration-isometrique-du-service-partage-voiture_1284-31041.jpg?w=740&t=st=1688510945~exp=1688511545~hmac=512ca5d8f53cca86057675fb41b3e7c30d2f05791fde6f420dfcf7b46464b831',
                    width: 400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 25),
                  ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        primary: Colors.indigo,
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignupScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        primary: Colors.white,
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
