import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/body.dart';
import '../components/search_box.dart';
import '../constants.dart';

class page_utilisateur extends StatelessWidget {
  static const routeName = '/user-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body: Body(index: 0), // Pass the desired index here
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: const Text('Liste des Utilisateurs'),
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
