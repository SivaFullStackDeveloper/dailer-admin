import 'dart:convert';
import 'package:dailer_admin/api/state_provider.dart';
import 'package:dailer_admin/theme.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:dio/dio.dart' ;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dailer_admin/api/delete.dart';
import 'package:dailer_admin/api/update.dart';
import 'package:dailer_admin/models/category_model.dart';
import 'package:dailer_admin/models/cities_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/get.dart';
import 'api/post.dart';
import 'dashboardScreen.dart';
import 'loginScreen.dart';
import 'models/cities_by_name.dart';

void main() async{
  runApp( MultiProvider(
      providers: [
        // Provider for user information
        ChangeNotifierProvider<StateProvider>(
          create: (context) => StateProvider(),
        ),

      ],child: MyApp(),));

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dash Board',
      theme:
      //adminTheme,
      ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        hintColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Colors.white, // Light background color
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white,),
          color: Colors.deepOrange,
          elevation: 0.0, // Remove shadow under the app bar
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.black), // App bar title color
          bodyText2: TextStyle(color: Colors.black), // Body text color
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, // Icon color
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white, // Text field background color
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepOrangeAccent),
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelStyle: const TextStyle(color: Colors.black), // Label text color
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
      ),
      home: AuthScreen(),
    );
  }
}




