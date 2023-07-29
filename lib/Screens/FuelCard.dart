import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet/models/fuelClass.dart';

import '../models/Cars.dart';
import '../models/User.dart';
class FuelCard extends StatefulWidget {
  final User user;
  final Voiture car;
  const FuelCard({required this.user, Key? key, required this.car}) : super(key: key);
  static const String  routeName = '/fuelCard';


  @override
  State<FuelCard> createState() => _FuelCardState();

}

class _FuelCardState extends State<FuelCard> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 844,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x4C183055),
                blurRadius: 50,
                offset: Offset(30, 40),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 844,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("http://192.168.1.16/carte.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 100,
                child: Container(
                  width: 342,
                  height: 656,
                  child: Stack(
                    children: [

                      Positioned(
                        left: 0,
                        top: 100,
                        child: Container(
                          width: 342,
                          height: 190,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 342,
                                  height: 190,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.96, -0.28),
                                      end: Alignment(-0.96, 0.28),
                                      colors: [Color(0xFF52B6FE), Color(0xFF6154FE)],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 342,
                                  height: 190,
                                  decoration: ShapeDecoration(
                                    color: Colors.white.withOpacity(0.029999999329447746),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -9,
                                top:-10,
                                child: Container(
                                  width: 360,
                                  height: 198.81,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 360,
                                          height: 198.81,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("http://192.168.1.16/card2.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0.14,
                                        child: Container(
                                          width: 358.79,
                                          height: 198.67,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("http://192.168.1.16/card2.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 25,
                                top: 83,
                                child: Text(
                                  widget.user.cin,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.33,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    height: 24.50,
                                    letterSpacing: 1.63,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 25,
                                top: 119,
                                child: Container(
                                  width: 262.48,
                                  height: 45,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 20,
                                        child: Text(
                                          'JENNER ANNE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            height: 24.52,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 197.48,
                                        top: 20,
                                        child: Text(
                                          '10/28',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            height: 24.52,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 197.48,
                                        top: 0,
                                        child: Opacity(
                                          opacity: 0.90,
                                          child: Text(
                                            'VALID TILL',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              height: 24.52,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0.48,
                                        top: 0,
                                        child: Opacity(
                                          opacity: 0.90,
                                          child: Text(
                                            'NAME',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              height: 24.52,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 25,
                                top: 25,
                                child: Container(
                                  width: 49,
                                  height: 49,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Stack(children: [

                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        top: 0,
                        child: Text(
                          'FuelCard',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}