/*
import 'dart:convert';
import 'package:dailer_admin/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'error.dart';



class RemoveUserFromGroupScreen extends StatefulWidget {
  @override
  _RemoveUserFromGroupScreenState createState() =>
      _RemoveUserFromGroupScreenState();
}

class _RemoveUserFromGroupScreenState extends State<RemoveUserFromGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> removeUserFromGroup(context) async {


    final Map<String, dynamic> requestData = {
      "groupName": groupNameController.text,
      "phoneNumber": phoneNumberController.text,
    };

    try {
      LoadingIndicatorPopup.show(context,true);
      final response = await http.delete(
        Uri.parse(baseUrl+ 'group/removeUserFromGroup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        LoadingIndicatorPopup.show(context,false);
        showSuccessPopup(context, "delete");

      } else {
        LoadingIndicatorPopup.show(context,false);
        ErrorDialog.show(context, response.statusCode.toString());
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      LoadingIndicatorPopup.show(context,false);
      ErrorDialog.show(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove User from Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: groupNameController,
              decoration: InputDecoration(labelText: 'Group Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                removeUserFromGroup(context);
              },
              child: Text('Remove User from Group'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
