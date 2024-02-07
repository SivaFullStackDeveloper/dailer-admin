import 'package:dailer_admin/api/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorDialog {
  static void show(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoadingIndicatorPopup {
  static void show(BuildContext context, bool isLoading) {
    if (isLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(20.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }
}

 showFirstPopup({context,screenName,field1Name,field2Name,field3Name,text1,text2,text3,id,method}) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var stateProvider = Provider.of<StateProvider>(context,listen:false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  stateProvider.updateFields(field1Text:text1,field2Text:text2,field3Text:text3,);
});
      return AlertDialog(
        title: Text('${method} ${screenName}'),
        content:  Form(
      key: formKey,
      child:
      Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextFormField(
                controller: stateProvider.field1Controller,
                decoration: InputDecoration(labelText: '${field1Name}'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${field1Name} cannot be empty';
                  }

                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: stateProvider.field2Controller,
                decoration: InputDecoration(labelText: '${field2Name}'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${field2Name} cannot be empty';
                  }

                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: stateProvider.field3Controller,
                decoration: InputDecoration(labelText: '${field3Name}'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${field1Name} cannot be empty';
                  }

                },
              ),
            ],
          ),
        ),),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if(screenName=='city'){
                  if(method=='update'){
                    stateProvider.updateCity(context:context,id:id,);
                    Navigator.of(context).pop();
                  }else{
                    stateProvider.createCity(context:context,);
                    Navigator.of(context).pop();
                  }
                }else {
                  if(method=='update'){
                    stateProvider.updateCategory(context:context,id:id,);
                    Navigator.of(context).pop();
                  }else{
                    stateProvider.createCategory(context:context,);
                    Navigator.of(context).pop();
                  }
                }


              }
            },
            child: Text(method),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

showThirdPopup({context,screenName,field1Name,field2Name,field3Name,text1,text2,text3,id,method}) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var stateProvider = Provider.of<StateProvider>(context,listen:false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        stateProvider.updateFields(field1Text:text1,field2Text:text2,field3Text:text3,);
      });
      return AlertDialog(
        title: Text('${method} ${screenName}'),
        content:  Form(
          key: formKey,
          child:
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                DropDown2(),
                const SizedBox(height: 20),
                TextFormField(
                  controller: stateProvider.field3Controller,
                  decoration: InputDecoration(labelText: '${field3Name}'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${field1Name} cannot be empty';
                    }

                  },
                ),
              ],
            ),
          ),),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {

                  if(method=='update'){
                    stateProvider.updateCity(context:context,id:id,);
                    stateProvider.getCities( context:context,  districtName:stateProvider.field2Controller.text);
                    Navigator.of(context).pop();
                  }else{
                    stateProvider.createCity(context:context,);
                    Navigator.of(context).pop();
                  }
              }
            },
            child: Text(method),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

showSecondPopup({context,screenName,field1Name,field2Name,text1,text2,id,method}) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var stateProvider = Provider.of<StateProvider>(context,listen:false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        stateProvider.updateFields2(field1Text:text1,field2Text:text2,);
      });
      return AlertDialog(
        title: Text('${method} ${screenName}'),
        content:  Form(
          key: formKey,
          child:
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextFormField(
                  controller: stateProvider.field1Controller,
                  decoration: InputDecoration(labelText: '${field1Name}'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${field1Name} cannot be empty';
                    }

                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: stateProvider.field2Controller,
                  decoration: InputDecoration(labelText: '${field2Name}'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${field2Name} cannot be empty';
                    }

                  },
                ),

              ],
            ),
          ),),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if(method=='update'){
                  stateProvider.updateMetroCity(context:context,id:id,);
                  Navigator.of(context).pop();
                }else{
                  stateProvider.createMetroCity(context:context,);
                  Navigator.of(context).pop();
                }

              }
            },
            child: Text(method),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}





 showSuccessPopup(BuildContext context,method) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessPopup(method: method,);
      },
    );
  }


class SuccessPopup extends StatefulWidget {
  var method;
   SuccessPopup({super.key,required this.method});

  @override
  _SuccessPopupState createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _animation,
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Successfully ${widget.method}!',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Close the pop-up


                Navigator.of(context).pop();


            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


 showDeleteConfirmation(BuildContext context,screenName,id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteConfirmationPopup(screenName:screenName,id: id,);
    },
  );
}


class DeleteConfirmationPopup extends StatelessWidget {
  var screenName;
  var id;
   DeleteConfirmationPopup( {super.key,required this.screenName,required this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {

            var stateProvider = Provider.of<StateProvider>(context,listen: false);
            if(screenName=='category'){
              stateProvider.deleteCategory(id: id,context:context);
            }else if(screenName =='metrocity'){
              stateProvider.deleteMetroCity(id: id,context:context);
            }else if(screenName=='city'){
              stateProvider.deleteCity(id: id,context:context);
            }

          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Change button color to red
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}



class DropDown2 extends StatefulWidget {
  @override
  _DropDown2State createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
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
              var stateProvider = Provider.of<StateProvider>(context,listen:false);
              stateProvider.field1Controller.text=selectedState;
            });
            Provider.of<StateProvider>(context,listen: false).getDistricts2(context: context,stateName: selectedState);
          },
          'Select State',
          states, // Replace with actual states
        ),

        buildDropdown(
          selectedDistrict,
              (value) {
            setState(() {
              selectedDistrict = value;
              var stateProvider = Provider.of<StateProvider>(context,listen:false);
              stateProvider.field2Controller.text=selectedDistrict;
            });
            Provider.of<StateProvider>(context,listen: false).getCities2(context: context,districtName:selectedDistrict);
          },
          'Select District',
          Provider.of<StateProvider>(context).allDistricts2, // Replace with actual states
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