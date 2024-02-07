import 'package:dailer_admin/api/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'error.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Categories'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                  showFirstPopup(context:context,
                      screenName: "Category",
                      field1Name: "Category Name",
                      field2Name: "Sub Category Name",
                      field3Name: "Key Words",
                      text1:'',
                      text2:'',
                      text3:'',
                      id:'',
                      method:"Create"
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                child: Text('Create New Category'),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<StateProvider>(
              builder:(context,value,child){
                return    Column(
                  children: [
                    Column(
                      children: [
                        // Row with category and subcategory
                        Container(
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Category name',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: SizedBox(),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Subcategory name',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: SizedBox(),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Keywords ',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: SizedBox(),),
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
                          physics:BouncingScrollPhysics(),
                          itemCount: value.categories.length, // +1 for the new category row
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CategoryForm2(subcategory: value.categories[i].subCategory, category: value.categories[i].categoryName, keywords: value.categories[i].keyWords,id: value.categories[i].id,),
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



class CategoryForm2 extends StatefulWidget {
  var id;
  var category;
  var subcategory;
  var keywords;

  CategoryForm2({super.key,required this.subcategory,required this.category,required this.keywords,required this.id});

  @override
  _CategoryForm2State createState() => _CategoryForm2State();
}

class _CategoryForm2State extends State<CategoryForm2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child:Text(widget.category,style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),)
        ),

        SizedBox(width: 16.0),

        Expanded(
            child:Text(widget.subcategory,style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),)
        ),
        SizedBox(width: 16.0),
        Expanded(
            child:Text(widget.keywords,style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),)
        ),
        SizedBox(width: 16.0),

      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
    children: [

      ElevatedButton(
        onPressed: (){
          showFirstPopup(context:context,
              screenName: "Category",
              field1Name: "Category Name",
              field2Name: "Sub Category Name",
              field3Name: "Key Words",
              text1:widget.category,
              text2:widget.subcategory,
              text3:widget.keywords,
              id:widget.id,
              method:"update"
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
        ),
        child: Text('Update'),
      ),
      SizedBox(width: 8.0),
      ElevatedButton(
        onPressed: (){
          showDeleteConfirmation(context,'category',widget.id);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
        child: Text('Delete'),
      ),
    ],)
      ],
    );

  }

}
