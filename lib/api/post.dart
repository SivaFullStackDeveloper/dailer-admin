import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error.dart';
import '../models/category_model.dart';
import '../models/cities_model.dart';
import '../models/metrocities.dart';
import '../theme.dart';
import 'dart:typed_data';


class PostApi {
  createCategory({categoryName, subCategory, keyWords, context}) async {
    LoadingIndicatorPopup.show(context, true);
    print({
      'categoryName': categoryName.toString(),
      'subCategory': subCategory.toString(),
      'keyWords': keyWords.toString(),
    });
    final response = await http.post(
      Uri.parse(baseUrl + 'category'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'categoryName': categoryName,
        'subCategory': subCategory,
        'keyWords': keyWords,
      }),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      LoadingIndicatorPopup.show(context, false);
      Categories category = Categories.fromJson(data['categories']);
      showSuccessPopup(context, "added");
      return category;
    } else {
      ErrorDialog.show(context, 'Failed to post data');
    }
  }

  createCity({state, district, city, context}) async {
    LoadingIndicatorPopup.show(context, true);
    final response = await http.post(
      Uri.parse(baseUrl + 'cities'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "state": state,
        "district": district,
        "city": city
      }
      ),
    );

    if (response.statusCode == 201) {
      dynamic data = json.decode(response.body);
      LoadingIndicatorPopup.show(context, false);
      showSuccessPopup(context, "added");
      return CitiesData.fromJson(data);
    } else {
      LoadingIndicatorPopup.show(context, false);
      ErrorDialog.show(context,
          ' Failed to create city. Status code: ${response.statusCode}');
    }
  }


  createMetroCity({metroCity, subCity, context}) async {
    try {
      // Show loading indicator
      LoadingIndicatorPopup.show(context, true);

      final response = await http.post(
        Uri.parse(baseUrl + 'metroCities'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'metroCity': metroCity,
          'subCity': subCity,
        }),
      );

      if (response.statusCode == 201) {
        LoadingIndicatorPopup.show(context, false);
        showSuccessPopup(context, "Added");
        var data = jsonDecode(response.body);

        return MetroCity.fromJson(data);
      } else {
        // Show error message
        ErrorDialog.show(context, 'Failed to post metro city data');
        LoadingIndicatorPopup.show(context, false);
        throw Exception("Failed to post metro city data");
      }
    } catch (error) {
      // Show error message
      ErrorDialog.show(context, error.toString());
      LoadingIndicatorPopup.show(context, false);
      throw Exception("An error occurred" + error.toString());
    }
  }


  Future uploadFile(Uint8List fileBytes, String fileName,context) async {
    LoadingIndicatorPopup.show(context, true);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl+'auth/upload'),
    );

    var imageFile = http.MultipartFile.fromBytes(
      'images',
      fileBytes,
      filename: fileName,
    );
    request.files.add(imageFile);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Upload successful');
        var responseData = await response.stream.bytesToString();
        var j = jsonDecode(responseData);
        print(j.runtimeType);
        SuccessPopup( method:'Upload',);
        LoadingIndicatorPopup.show(context, false);
        return jsonDecode(responseData);
      } else {
        print('Upload failed with status ${response.statusCode}');
        ErrorDialog.show(context, 'Error uploading image');
        LoadingIndicatorPopup.show(context, false);
      }
    } catch (error) {
      print('Error uploading image: $error');
      ErrorDialog.show(context, 'Error uploading image: ${error.toString()}');
      LoadingIndicatorPopup.show(context, false);
      throw Exception("An error occurred" + error.toString());
    }
  }

updateBusinessUser(Map<String, dynamic> postData,context) async {
    var url = baseUrl+'admin/updateBusiness'; // Replace with your actual API endpoint

    try {
     LoadingIndicatorPopup.show(context, true);
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postData),
      );
      print('Response: ${response.body}');
      if (response.statusCode == 201) {
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


