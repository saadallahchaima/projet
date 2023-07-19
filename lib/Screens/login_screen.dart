import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../entry_point.dart';
import 'WelcomScreen.dart';
import 'signup_screen.dart';
import 'home/homepage.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscurePassword = true;

  Future<void> _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    var url = Uri.parse("http://192.168.1.15/projet_api/login.php");
    var response = await http.post(
      url,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      String status = responseData["status"];

      if (status == "success") {
        Navigator.pushNamed(context, EntryPoint.routeName);
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Erreur de connexion'),
            content: Text('Les informations de connexion sont incorrectes.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Erreur de requête HTTP
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erreur'),
          content: Text('Une erreur s\'est produite lors de la connexion.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(SignupScreen.routeName),
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }

  Widget logout(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(WelcomeScreen.routeName),
            child: Text('LogOut'),
          ),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          obscureText: keyboardType == TextInputType.visiblePassword ? isObscurePassword : false,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
            border: InputBorder.none,
            suffixIcon: keyboardType == TextInputType.visiblePassword
                ? IconButton(
              icon: Icon(isObscurePassword ? Icons.visibility_off : Icons.visibility),
              color: Colors.grey,
              onPressed: () {
                setState(() {
                  isObscurePassword = !isObscurePassword;
                });
              },
            )
                : null,
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 700,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    Image.network(
                      'https://img.freepik.com/vecteurs-libre/prix-eleve-pour-concept-carburant-voiture-gens-gaspillent-argent-pour-essence-changent-voiture-pour-scooter-economisent-argent-illustration-vectorielle-plane-pour-economie-ravitaillement-concept-transport-urbain_74855-10089.jpg?w=1060&t=st=1688502380~exp=1688502980~hmac=.jpg',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    userInput(emailController, 'Email', TextInputType.emailAddress),
                    userInput(passwordController, 'Password', TextInputType.visiblePassword),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          primary: Colors.indigo.shade800,
                        ),
                        onPressed: _login,
                        //onPressed: () => Navigator.of(context).pushNamed(EntryPoint.routeName),

                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(child: Text('Forgot password ?')),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          login(Icons.add),
                          logout(Icons.logout),
                        ],
                      ),
                    ),
                    Divider(thickness: 0, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
