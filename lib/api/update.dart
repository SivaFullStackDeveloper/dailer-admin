
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error.dart';
import '../models/category_model.dart';
import '../models/cities_model.dart';
import '../theme.dart';

class UpdateApi{
 patchData({required categoryId,required categoryName, required subCategory, required keyWords, required context}) async {
  try{ LoadingIndicatorPopup.show(context, true);
    final response = await http.patch(
      Uri.parse(baseUrl+'category/$categoryId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'categoryName': categoryName,
        'subCategory': subCategory,
        'keyWords': keyWords,
      }),
    );
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      LoadingIndicatorPopup.show(context, false);
      showSuccessPopup(context, "Updated");
      return Categories.fromJson(data['categories']);
    } else {
      LoadingIndicatorPopup.show(context,false);
      ErrorDialog.show(context,'Failed to patch data');
    }
 } catch (error) {
 // Show error message
 ErrorDialog.show(context, error.toString());

 }
  }

  updateCity(String cityId, {state, district, city,context}) async {
   try{ LoadingIndicatorPopup.show(context, true);
    final response = await http.patch(
      Uri.parse(baseUrl+'cities/$cityId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "state":state,
        "district":district,
        "city":city
      }),
    );
print(response.statusCode.toString()+'cities update');
    if (response.statusCode == 200) {
      LoadingIndicatorPopup.show(context, false);
      dynamic data = json.decode(response.body);
      showSuccessPopup(context, "Updated");
      return  CitiesData.fromJson(data['cities']);
    } else {
      LoadingIndicatorPopup.show(context,false);
      ErrorDialog.show(context,'Failed to update city. Status code: ${response.statusCode}');
    }
  } catch (error) {
 // Show error message
 ErrorDialog.show(context, error.toString());
 throw Exception("An error occurred: $error");
 }
  }
 Future<Map<String, dynamic>> updateMetroCity({ metroCity,  subCity,  id, context}) async {
   try {
     // Show loading indicator
     LoadingIndicatorPopup.show(context, true);

     final response = await http.patch(
       Uri.parse(baseUrl + 'metroCities/$id'), // Assuming you have an endpoint like /metroCities/:id for updating
       headers: <String, String>{
         'Content-Type': 'application/json',
       },
       body: jsonEncode({
         'metroCity': metroCity,
         'subCity': subCity,
       }),
     );

     // Hide loading indicator
     LoadingIndicatorPopup.show(context, false);

     if (response.statusCode == 200) {
       var data = jsonDecode(response.body);
       showSuccessPopup(context, "Updated");
       return data;
     } else {
       // Show error message
       ErrorDialog.show(context, 'Failed to update metro city data');
       throw Exception("Failed to update metro city data");
     }
   } catch (error) {
     // Show error message
     ErrorDialog.show(context, error.toString());
     throw Exception("An error occurred: $error");
   }
 }


 updateUser(Map<String, dynamic> patchData,context) async {
   var url = baseUrl+'admin/updateUser'; // Replace with your actual API endpoint

   try {
     LoadingIndicatorPopup.show(context, true);
     final response = await http.patch(
       Uri.parse(url),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode(patchData),
     );

     print('Response: ${response.body}');
     if (response.statusCode == 200) {
       LoadingIndicatorPopup.show(context, false);
       SuccessPopup(method: 'update',);
       print('Post request successful');
       print('Response: ${response.body}');
     } else {
       ErrorDialog.show(context, ' Failed to make post request. Status code: ${response.statusCode} Response: ${response.body}');
       LoadingIndicatorPopup.show(context, false);
       throw Exception("Failed to make post request. Status code: ${response.statusCode}");
     }
   } catch (error) {
     print('Error: $error');
     LoadingIndicatorPopup.show(context, false);
     ErrorDialog.show(context,  error.toString());
     throw Exception("An error occurred" + error.toString() );
   }
 }

}