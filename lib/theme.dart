import 'package:flutter/material.dart';


final ThemeData adminTheme = ThemeData.light().copyWith(
  primaryColor: Colors.deepOrange,
  hintColor: Colors.deepOrangeAccent,
  scaffoldBackgroundColor: Colors.white, // Light background color
  appBarTheme: AppBarTheme(
    color: Colors.deepOrange,
    elevation: 0.0, // Remove shadow under the app bar
  ),
  textTheme: TextTheme(
    headline6: TextStyle(color: Colors.black), // App bar title color
    bodyText2: TextStyle(color: Colors.black), // Body text color
  ),
  iconTheme: IconThemeData(
    color: Colors.black, // Icon color
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white, // Text field background color
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrangeAccent),
      borderRadius: BorderRadius.circular(8.0),
    ),
    labelStyle: TextStyle(color: Colors.black), // Label text color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.deepOrange, // Button background color
      onPrimary: Colors.white, // Button text color
      elevation: 3.0, // Button shadow elevation
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor:Colors.deepOrangeAccent,
      primary: Colors.deepOrangeAccent, // TextButton background color
      onSurface: Colors.white, // TextButton text color
    ),
  ),
);


const baseUrl = "https://dailer-backend.onrender.com/api/v1/";


