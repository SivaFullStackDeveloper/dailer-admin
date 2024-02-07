import 'package:dailer_admin/models/metrocities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/delete.dart';
import 'api/get.dart';
import 'api/post.dart';
import 'api/state_provider.dart';
import 'api/update.dart';
import 'dashboardScreen.dart';
import 'main.dart';
import 'models/category_model.dart';
import 'models/cities_by_name.dart';
import 'models/cities_model.dart';


class AuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StateProvider>(context,listen: false).allCities(context);
      Provider.of<StateProvider>(context,listen: false).getCategory(context);
      Provider.of<StateProvider>(context,listen: false).getMetroCities(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Admin Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => DashboardScreen(),
                    ),
                        (route) => false,//if you want to disable back feature set to false
                  );
                },
                child: Text('Login'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to registration screen

                    },
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
