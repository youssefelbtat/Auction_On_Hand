

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData lightTheme=ThemeData(
 brightness: Brightness.light,
  primarySwatch: primeColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  const AppBarTheme(
   // backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black38 ,
    ),
    backgroundColor: Colors.white ,
    elevation: 0.0 ,
    titleTextStyle: TextStyle(
      color: Colors.black ,
      fontSize: 20.0 ,
      fontWeight: FontWeight.w600 ,
    ),
    iconTheme: IconThemeData(
      color: Colors.black ,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white ,
    unselectedItemColor: Colors.grey ,
    selectedItemColor: primColor ,
  ),
  textTheme: TextTheme(
    button: TextStyle(
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      color: Colors.black ,
      fontSize: 17.0 ,
    ),
      bodyText2: TextStyle(
        color: graycolor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.aleo(
      textStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    ),

  ),
);
ThemeData darkTheme=ThemeData(
  brightness: Brightness.dark,
  primarySwatch: primeColor,
  scaffoldBackgroundColor: Colors.black12,
  appBarTheme: const AppBarTheme(
    //backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black38 ,
    ),
    backgroundColor: Colors.black ,
    elevation: 0.0 ,
    titleTextStyle: TextStyle(
      color: Colors.white ,
      fontSize: 20.0 ,
      fontWeight: FontWeight.w600 ,
    ),
    iconTheme: IconThemeData(
      color: Colors.white ,
    ),
  ),
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    backgroundColor: Colors.black12 ,
    unselectedItemColor: Colors.grey ,
    selectedItemColor: primColor ,
  ),
  textTheme: TextTheme(
    button: TextStyle(
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      color: Colors.white ,
      fontSize: 17.0 ,
    ),
    bodyText2: TextStyle(
      color: graycolor,
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.aleo(
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

    ),
  ),
);