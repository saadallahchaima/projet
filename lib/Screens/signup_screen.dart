import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet/Screens/select_photo_options_screen.dart';

import '../models/mysql.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/animation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final UserNameController = TextEditingController();
  final UserPhoneController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final cartecinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  File? _image;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Vérification de la présence d'au moins un chiffre
    if (!value.contains(RegExp(r'\d'))) {
      return 'Password must contain at least one digit';
    }

    // Vérification de la présence d'au moins un caractère spécial
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null; // La validation a réussi
  }
  String? pickedImagePath;

  void _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        pickedImagePath = img?.path;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }
  void _showAnimatedDialog(String message, IconData icon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 16.0),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  var db = Mysql();
  var mail = '';
  bool circular = false;

  Future<void> senddata({String? imagePath}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 16.0),
              Text(
                "Registration in progress...",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (_formKey.currentState!.validate()) {
      var response = await http.post(Uri.parse("http://192.168.1.15/projet_api/insertdata.php"), body: {
        "nom": UserNameController.text,
        "email": emailController.text,
        "phone": UserPhoneController.text,
        "password": passwordConfirmController.text,
        "cin": cartecinController.text,
      });

      Navigator.of(context).pop(); // Ferme le dialogue "Registration in progress..."


      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["status"] == "error") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/crossred.png",
                      width: 60.0,
                      height: 60.0,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Registration failed!",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (data["status"] == "success") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 4.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 60.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Registration successful!",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"),
                    ),
                  ],
                ),
              );
            },
          );
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: _pickImage,
            ),
          );
        },
      ),
    );
  }

  Widget signUpWith(BuildContext context, IconData icon) {
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
            onPressed: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
            child: Text('Sign in'),
          ),
        ],
      ),
    );
  }

  Widget userInput(
      TextEditingController userInput,
      String hintTitle,
      TextInputType keyboardType,
      IconData iconData, {
        required String? Function(String? value) validator,
      }) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextFormField(
          controller: userInput,
          validator: validator,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Icon(iconData), // Ajout de l'icône ici
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
              child: ListView(
                children: [
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 45),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Center(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    _showSelectPhotoOptions(context);
                                  },
                                  child: Container(
                                    height: 200.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Center(
                                      child: _image == null
                                          ? const Text(
                                        'No image selected',
                                        style: TextStyle(fontSize: 20),
                                      )
                                          : CircleAvatar(
                                        backgroundImage: FileImage(_image!),
                                        radius: 100.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              userInput(
                                UserNameController,
                                'Full Name',
                                TextInputType.name,
                                Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null; // La validation a réussi
                                },
                              ),
                              userInput(
                                UserPhoneController,
                                'Phone Number',
                                TextInputType.phone,
                                Icons.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null; // La validation a réussi
                                },
                              ),
                              userInput(
                                emailController,
                                'Email',
                                TextInputType.emailAddress,
                                Icons.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!emailRegExp.hasMatch(value)) {
                                    return 'Invalid email';
                                  }
                                  return null; // La validation a réussi
                                },
                              ),
                              userInput(
                                passwordController,
                                'Password',
                                TextInputType.visiblePassword,
                                Icons.lock,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }

                                  return null; // La validation a réussi
                                },
                              ),
                              userInput(
                                cartecinController,
                                'votre carte d''identité',
                                TextInputType.number,
                                Icons.card_membership,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your CIN';
                                  }
                                  if (value.length != 8) {
                                    return 'CIN must be 8 digits';
                                  }
                                  return null; // La validation a réussi
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 55,
                          padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), backgroundColor: Colors.indigo.shade800,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                senddata();
                              }
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              signUpWith(context, Icons.logout),
                            ],
                          ),
                        ),
                        Divider(thickness: 0, color: Colors.white),
                      ],
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
