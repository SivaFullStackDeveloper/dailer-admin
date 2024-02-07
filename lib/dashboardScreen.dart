import 'package:dailer_admin/api/state_provider.dart';
import 'package:dailer_admin/today_registers.dart';
import 'package:dailer_admin/user_deatils_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'allCities.dart';
import 'categoriesScreen.dart';
import 'metro_cities_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;
  List<Widget> screens = [
    UserDetails(),
    CitiesScreen(),
    CategoriesScreen(),
    AllCitiesScreen(),
    AllUserScrees(),
    //RemoveUserFromGroupScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Expanded(flex: 1,child:Container(child:
      Consumer<StateProvider>(
        builder: (context,value,child) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height:56.5,
                color: Colors.deepOrange,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: value.index == 4 ? Colors.white : Colors.deepOrange,
                  ),
                  tileColor:
                  value.index == 4 ? Colors.deepOrange : Colors.transparent,
                  title: Text(
                    'Today Registered users',
                    style: TextStyle(
                      color: value.index == 4 ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {

                    value.dashBoardUpdate(4);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: value.index == 0 ? Colors.white : Colors.deepOrange,
                  ),
                  tileColor:
                  value.index == 0 ? Colors.deepOrange : Colors.transparent,
                  title: Text(
                    'User Details',
                    style: TextStyle(
                      color: value.index == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {

                    value.dashBoardUpdate(0);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.location_city_outlined,
                    color: value.index == 3 ? Colors.white : Colors.deepOrange,
                  ),
                  tileColor:
                  value.index == 3 ? Colors.deepOrange : Colors.transparent,
                  title: Text(
                    'All Cities',
                    style: TextStyle(
                      color: value.index == 3 ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {

                    value.dashBoardUpdate(3);

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor:
                  value.index == 1 ? Colors.deepOrange : Colors.transparent,
                  leading: Icon(
                    Icons.location_city,
                    color: value.index == 1 ? Colors.white : Colors.deepOrange,
                  ),
                  title: Text(
                    'Metro Cities',
                    style: TextStyle(
                      color: value.index == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {

                    value.dashBoardUpdate(1);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.category,
                    color: value.index == 2 ? Colors.white : Colors.deepOrange,
                  ),
                  tileColor:
                  value.index == 2 ? Colors.deepOrange : Colors.transparent,
                  title: Text(
                    'Categories',
                    style: TextStyle(
                      color: value.index == 2 ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {

                    value.dashBoardUpdate(2);
                  },
                ),
              ),
            ],
          );
        }
      ),),),
         Expanded(flex: 3,child:Consumer<StateProvider>(
    builder: (BuildContext context,value, Widget? child) {
      print(value.index);
    return screens[value.index];}),)
        ],
      ),
    );
  }
}
