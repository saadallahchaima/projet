import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
        required this.stateMachineName,
        required this.title,
        this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset("assets/home.riv",
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat"),
  RiveAsset("assets/home.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"),
  RiveAsset("assets/home.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "Chat"),
  RiveAsset("assets/home.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notifications"),
  RiveAsset("assets/home.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
];

List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/home.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
  ),
  RiveAsset(
    "assets/home.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Search",
  ),
  RiveAsset(
    "assets/home.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "History",
  ),
  RiveAsset(
    "assets/home.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Help",
  ),
];

List<RiveAsset> sideMenu2 = [

  RiveAsset(
    "assets/home.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notification",
  ),



];