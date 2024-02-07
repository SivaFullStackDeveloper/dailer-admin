import 'package:dailer_admin/api/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'error.dart';

class CitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Metro Cities'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                  showSecondPopup(context:context,
                      screenName: "Metro City",
                      field1Name: "Metro City Name",
                      field2Name: "Sub City Name",
                      text1:"",
                      text2:"",
                      id:"",
                      method:"create"
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                child: const Text('Create New Metro City'),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<StateProvider>(
              builder:(context,value,child){
                return Column(
                  children: [

                    Column(
                      children: [
                        // Row with category and subcategory
                        Container(
                          color: Colors.black,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Metro',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: SizedBox(),),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'City name',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: SizedBox(),),
                              SizedBox(width:80)
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
                      padding: const EdgeInsets.only(top:8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics:const BouncingScrollPhysics(),
                          itemCount: value.metroCities.length, // +1 for the new category row
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CitiesForm2(metroCity: value.metroCities[i].metroCity, subCity: value.metroCities[i].subCity,id: value.metroCities[i].id,),
                            );
                          }),
                    )
                  ],
                );
              }
            )

          ),
        ));
  }
}

class CitiesForm extends StatefulWidget {
  @override
  _CitiesFormState createState() => _CitiesFormState();
}

class _CitiesFormState extends State<CitiesForm> {
  final TextEditingController metroPolitianNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _createCategory() {
    if (_formKey.currentState!.validate()) {
      // Perform category creation logic here
      String categoryName = metroPolitianNameController.text;
      String subcategory = cityController.text;
      // Add your logic to create a new category

    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextFormField(
              controller: metroPolitianNameController,
              decoration: const InputDecoration(labelText: 'Metro politian City Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Metro politian City name cannot be empty';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: TextFormField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'City'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'city cannot be empty';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: _createCategory,
            child: const Text('Create city'),
          ),
        ],
      ),
    );
  }
}


class CitiesForm2 extends StatefulWidget {
  var metroCity;
  var subCity;
  var id;
  CitiesForm2({super.key,required this.metroCity,required this.subCity,required this.id});

  @override
  _CitiesForm2State createState() => _CitiesForm2State();
}

class _CitiesForm2State extends State<CitiesForm2> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child:Text(widget.metroCity,style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),)
        ),
        const SizedBox(width: 16.0),
        Expanded(
            child:Text(widget.subCity,style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),)
        ),
        const SizedBox(width: 16.0),


      ],
    ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: (){
                showSecondPopup(context:context,
                    screenName: "metrocity",
                    field1Name: "Metro City Name",
                    field2Name: "Sub City Name",
                    text1:widget.metroCity,
                    text2:widget.subCity,
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
              onPressed: (){
                showDeleteConfirmation(context,'metrocity',widget.id);
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
