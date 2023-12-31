import 'dart:convert';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../entry_point.dart';
import 'WelcomScreen.dart';
import 'ajouter_info.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscurePassword = true;
  late final String? finalEmail; // Make it nullable

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
            onPressed: () =>
                Navigator.of(context).pushNamed(SignupScreen.routeName),
            child: const Text('Sign up'),
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
            onPressed: () =>
                Navigator.of(context).pushNamed(WelcomeScreen.routeName),
            child: const Text('LogOut'),
          ),
        ],
      ),
    );
  }
  Future<void> getValidationData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }
  Future<void> _login() async {
    String email = emailController.text;
  String password = passwordController.text;

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
sharedPreferences.setString('email',emailController.text);
    var url = Uri.parse("http://192.168.1.11/projet_api/test.php");
    var response = await http.post(
      url,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var role = responseData['role'];
      if (role == 'admin') {
        Get.toNamed(EntryPoint.routeName);
      } else if (role == 'chauffeur') {
        Get.toNamed(ListTest.routeName);
      } else {
        showDialog(
          context: context,
          builder: (ctx) =>
              AlertDialog(
                title: const Text('Erreur de connexion'),
                content: const Text(
                    'Les informations de connexion sont incorrectes.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    } else {
      // Erreur de requête HTTP
      showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: const Text('Erreur'),
              content: const Text(
                  'Une erreur s\'est produite lors de la connexion.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }

  }


  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(bottom: 15),
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
            hintStyle: const TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
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
                const SizedBox(height: 45),
                Image.network(
                  'http://192.168.1.11/login_image.avif',
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), backgroundColor: Colors.indigo.shade800,
                    ),
                    onPressed: _login,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(child: Text('Forgot password ?')),
                const SizedBox(height: 20),
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
                const Divider(thickness: 0, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}