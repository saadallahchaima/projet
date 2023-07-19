import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateRecord extends StatefulWidget {
  final String nom;
  final String email;
  final String phone;
  final String cin;

  UpdateRecord(this.nom, this.email, this.phone, this.cin);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cin = TextEditingController();

  Future<void> updateRecord() async {
    try {
      String uri = "http://192.168.1.15/projet_api/update_user.php";
      var res = await http.post(Uri.parse(uri), body: {
        "nom": name.text,
        "email": email.text,
        "phone": phone.text,
        "cin": cin.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("updated");
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    name.text = widget.nom;
    email.text = widget.email;
    phone.text = widget.phone;
    cin.text = widget.cin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //  leading: EdgeInsets.all(15),
        title: Text('Update Record'),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 4, color: Colors.white),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://img.freepik.com/vecteurs-libre/homme-affaires-caractere-avatar-isole_24877-60111.jpg?size=626&ext=jpg&ga=GA1.2.1739774954.1665308545&semt=sph",
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the name',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the email',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the phone',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cin,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the cin',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateRecord();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
