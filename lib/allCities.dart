import 'package:dailer_admin/api/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'error.dart';

class AllCitiesScreen extends StatefulWidget {
  @override
  State<AllCitiesScreen> createState() => _AllCitiesScreenState();
}

class _AllCitiesScreenState extends State<AllCitiesScreen> {
  String selectedState = '';
  String selectedDistrict = '';
  String selectedCity = '';


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          automaticallyImplyLeading: false,
          title: const Text('All Cities'),
          actions: [

          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Consumer<StateProvider>(
              builder: (context, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                          ElevatedButton(
                            onPressed: () {
                              showFirstPopup(context:context,
                                  screenName: "city",
                                  field1Name: "state Name",
                                  field2Name: "district Name",
                                  field3Name: "City Name",
                                  text1:'',
                                  text2:'',
                                  text3:'',
                                  id:'',
                                  method:"create"
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                            ),
                            child: const Text('Create New City'),
                          ),
                          SizedBox(height:10),
                          ElevatedButton(
                            onPressed: () {
                              showThirdPopup(context:context,
                                  screenName: "city",
                                  field1Name: "state Name",
                                  field2Name: "district Name",
                                  field3Name: "City Name",
                                  text1:'',
                                  text2:'',
                                  text3:'',
                                  id:'',
                                  method:"create"
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                            ),
                            child: const Text('Create City In Existing Data'),
                          ),
                        ]),
                  ],
                ),
                    DropDown(),
                    Column(
                      children: [
                        Container(
                          color: Colors.black,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Metro',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'District name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'City name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              SizedBox(width: 80)
                            ],
                          ),
                        ),
                        // Divider
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: value.allCitiesData.length,
                          // +1 for the new category row
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: AllCitiesForm2(
                                city: value.allCitiesData[i].city.toString(),
                                district: value.allCitiesData[i].district.toString(),
                                state: value.allCitiesData[i].state.toString(),
                                id: value.allCitiesData[i].id,
                              ),
                            );
                          }),
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }

}



class AllCitiesForm2 extends StatefulWidget {
  var city;
  var state;
  var district;
  var id ;

  AllCitiesForm2(
      {super.key, required this.city, required this.state, required this.district,required this.id});

  @override
  _AllCitiesForm2State createState() => _AllCitiesForm2State();
}

class _AllCitiesForm2State extends State<AllCitiesForm2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child:Text(widget.state,style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),)
        ),
        const SizedBox(width: 16.0),
        Expanded(
            child: Text(
              widget.district,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(width: 16.0),
        Expanded(
            child: Text(
              widget.city,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(width: 16.0),

      ],
    ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                showThirdPopup(context:context,
                    screenName: "city",
                    field1Name: "state Name",
                    field2Name: "district Name",
                    field3Name: "City Name",
                    text1:widget.state,
                    text2:widget.district,
                    text3:widget.city,
                    id:widget.id,
                    method:"update"
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
              ),
              child: const Text('Update'),
            ),
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {
                showDeleteConfirmation(context,'city',widget.id);

              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        )

      ],
    );

  }
}


class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String selectedState = 'Andhra Pradesh';
  String selectedDistrict = 'Select District';
  String selectedCity = '';
  List<String> states = [
    'Andaman And Nicobar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh',
    'Chhattisgarh',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu And Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Ladakh',
    'Lakshadweep',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Puducherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'The Dadra And Nagar Haveli And Daman And Diu',
    'Tripura',
    'Uttarakhand',
    'Uttar Pradesh',
    'West Bengal',
  ];

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDropdown(
          selectedState,
              (value) {
            setState(() {
              selectedState = value;
            });
            Provider.of<StateProvider>(context,listen: false).getDistricts(context: context,stateName: selectedState);
          },
          'Select State',
          states, // Replace with actual states
        ),

        buildDropdown(
          selectedDistrict,
              (value) {
            setState(() {
              selectedDistrict = value;
            });
            Provider.of<StateProvider>(context,listen: false).getCities(context: context,districtName:selectedDistrict);
          },
          'Select District',
          Provider.of<StateProvider>(context).allDistricts, // Replace with actual states
        )

      ],
    );

  }

  Widget buildDropdown(
      String selectedValue,
      ValueChanged onChanged,
      String hintText,
      List<String> items,
      ) {
    return DropdownButton<String>(
      isExpanded:true,
      value: selectedValue,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      hint: Text(hintText),
    );
  }
}


