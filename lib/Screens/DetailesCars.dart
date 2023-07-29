import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/text_constants.dart';
import '../models/Cars.dart';
import '../models/User.dart';

class DetailCars extends StatelessWidget {
  final Voiture car;
  String routeName = 'CarProfileScreen';
  DetailCars({Key? key, required this.car}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Color(0xFF092562),

          title: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white60,
                size: 30,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white60,
                  size: 30,
                ),
              )
            ],
          ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             TopMenuAndShowcase(v: car,),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 15, 0, 10),
              child: Text(
                car.marque,
                style: TextConstants.titleSection,
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: Color(0xFF092562),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/icons/ic_speedometer.png",
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: car.kilometrage),
                                  TextSpan(
                                    text: ' km/h',
                                    style: TextStyle(
                                      color: Colors.white38,
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: Color(0xFF092562),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotatedBox(
                              quarterTurns: 1,
                              child: Image.asset(
                                "assets/icons/ic_cartopview.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                children: <TextSpan>[
                                  for (var fuelFillup in car.fuelFillups)
                                    TextSpan(
                                      text:  'Litres: ${fuelFillup.numberOfLiters}',
                                    ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Type de Carburant:",
                        style: TextConstants.titleSection,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.directions_walk,
                            size: 24,
                            color: Colors.black54,
                          ),
                          Text(
                            car.kilometrage,
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.ev_station,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        car.type_c,
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),

                      ),

                    ],

                  ),


                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Column(
                      children: [

                        if (car.fuelFillups.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fuel Price:",
                                style: TextConstants.titleSection,
                              ),
                              for (var fillup in car.fuelFillups)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.price_change,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${fillup.prix} '\$' - ${fillup.date.toString()}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],

              ),

            ),
          ],

        ),
        bottomSheet: const PriceAndBookNow(),
      ),
    );
  }
}

class PriceAndBookNow extends StatelessWidget {
  const PriceAndBookNow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
                children: const <TextSpan>[
                 // TextSpan(text: '\$180'),
                  //TextSpan(
                  //    text: '/day', style: TextStyle(color: Colors.black38)),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class TopMenuAndShowcase extends StatelessWidget {
  final Voiture v;

  TopMenuAndShowcase({
    Key? key,
    required this.v,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: const BoxDecoration(
        color: Color(0xFF092562),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 70,
            right: 20,
            left: 20,
            bottom: 0,
            child: Image.asset(
              "assets/images/tesla_1.png",
              width: 300,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 18, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                spreadRadius: 0.5)
                          ],
                        ),
                        child: Image.asset(
                          "assets/logos/ic_tesla_black.png",
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${v.marque}",
                              style: TextConstants.carName,
                            ),
                            Text(
                              "${v.model}",
                              style: TextConstants.producedDate,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.car_crash_rounded,
                            color: Colors.orange,
                          ),
                          Text(
                            "${v.model}",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}