import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet/Screens/login_screen.dart';
import 'package:rive/rive.dart';


import '../Screens/signup_screen.dart';
import '../models/rive_asset.dart';
import '../utils/rive_utils.dart';
import 'info_card.dart';
import 'side_menu_tile.dart';

// Welcome to the Episode 5
class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;



  // Rest of your app configuration...

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(

        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const infocard(
                name: "chaima",
                profession: "account",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),

              ...sideMenus.map(
                    (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    // Let me show you if user click on the menu how to show the animation
                    StateMachineController controller =
                    RiveUtils.getRiveController(artboard,
                        stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                    // See as we click them it start animate
                  },

                      press: () {
                        if (menu.input != null) {
                          setState(() {
                            selectedMenu = menu;
                          });

                          // Déclencher l'animation
                          menu.input!.change(true);
                          Future.delayed(const Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });

                          // Naviguer vers l'écran souhaité en fonction du menu sélectionné
                          if (selectedMenu == sideMenus[0]) {

                            Navigator.pushNamed(context, '/UsersAccounts-screen');
                          } else if (selectedMenu == sideMenus[1]) {

                            Navigator.pushNamed(context, '/signup-screen');
                          }
                          // Ajouter d'autres conditions pour les autres menus si nécessaire
                        }
                      },



                      isActive: selectedMenu == menu,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenu2.map(
                    (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    // Let me show you if user click on the menu how to show the animation
                    StateMachineController controller =
                    RiveUtils.getRiveController(artboard,
                        stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                    // See as we click them it start animate
                  },
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}