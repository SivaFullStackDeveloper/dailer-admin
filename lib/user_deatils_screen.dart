import 'package:dailer_admin/user_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'api/state_provider.dart';
import 'models/user_details.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading:false,
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(),
          ],
        ),
      ),
    );
  }
}



class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<StateProvider>(
        builder: (context,value,child){
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Enter phone number',
                        hintText: 'Enter phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Call API when the search button is clicked
                     value.userPhoneSearchApi(context,int.parse(_searchController.text));
                    },
                    child: Text('Search'),
                  ),
                ],
              ),

              Divider(height: 50,color: Colors.black,),
              value.combinedUserData.isNotEmpty? _buildUserCard(context,value.combinedUserData):Text("No Users Found"),
              value.combinedUserData.isNotEmpty? _buildUserCard2(context,value.combinedUserData):Text("No Business Account"),
            ],
          );
        },
      )

    );
  }
  Widget _buildUserCard(BuildContext context, List<CombinedUserData> user) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child:  ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user[0].user.profilePicture??''),
      ),
      title: Text(user[0].user.name??''),
      subtitle: Text(user[0].user.phoneNumber.toString()??""),


      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileForm( user: user,),
          ),
        );
      },
      ));
  }
  Widget _buildUserCard2(BuildContext context, List<CombinedUserData> businessUser) {
    return Card(
        margin: EdgeInsets.all(8.0),
        child:  ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(businessUser[0].businessUser.businessProfilePhoto??'https://dailer-backend.onrender.com/uploads/profile.png'),
          ),
          title: Text(businessUser[0].businessUser.businessName??''),
          subtitle: Text(businessUser[0].businessUser.phoneNum1.toString()??""),
          trailing: Text(businessUser[0].user.businessRegister==false?
          "":"Do Not Have Business",
            style: TextStyle(
              color: businessUser[0].user.businessRegister==false?Colors.red:Colors.transparent,
              fontSize: 20,fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessProfileScreen( userData: businessUser[0].businessUser, userData1:  businessUser[0].user,),
              ),
            );
          },
        ));
  }
}

