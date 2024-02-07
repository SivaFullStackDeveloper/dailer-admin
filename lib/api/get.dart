import 'dart:convert';
import 'package:dailer_admin/models/businessUserByDate.dart';
import 'package:http/http.dart' as http;
import '../error.dart';
import '../models/category_model.dart';
import '../models/cities_by_name.dart';
import '../models/cities_model.dart';
import '../models/metrocities.dart';
import '../models/user_details.dart';
import '../theme.dart';

class GetApi {
  fetchCategoryData(context) async {
    final response = await http.get(Uri.parse(baseUrl + 'category/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Categories.fromJson(json)).toList();
    } else {
      ErrorDialog.show(context,
          ' Failed to load categories data. Status code: ${response.statusCode}');
    }
  }

  fetchCities(context) async {
    final response = await http.get(Uri.parse(baseUrl + 'cities'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => CitiesData.fromJson(data[0])).toList();
    } else {
      ErrorDialog.show(
          context, 'Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  Future getCitiesStates(context) async {
    LoadingIndicatorPopup.show(context, true);
    try {
      var uri = Uri.parse(baseUrl + 'cities/states');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        LoadingIndicatorPopup.show(context, false);
        return StatesData.fromJson(json.decode(response.body));
      } else {
        LoadingIndicatorPopup.show(context, false);
        ErrorDialog.show(context,
            'Failed to fetch Cities States data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      LoadingIndicatorPopup.show(context, false);
      ErrorDialog.show(
          context, 'An error occurred while fetching Cities States data: $e');
    }
  }

  Future getCitiesDistricts(String state, context) async {
    LoadingIndicatorPopup.show(context, true);
    try {
      var uri = Uri.parse(baseUrl + 'cities/districts?state=$state');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        LoadingIndicatorPopup.show(context, false);
        return DistrictsData.fromJson(json.decode(response.body));
      } else {
        LoadingIndicatorPopup.show(context, false);
        ErrorDialog.show(context,
            'Failed to fetch Cities Districts data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      LoadingIndicatorPopup.show(context, false);
      ErrorDialog.show(context,
          'An error occurred while fetching Cities Districts data: $e');
    }
  }

  Future getCitiesByDistrict(String district, context) async {
    LoadingIndicatorPopup.show(context, true);
    try {
      var uri = Uri.parse(baseUrl + 'cities/cities?district=$district');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        LoadingIndicatorPopup.show(context, false);
        return json.decode(response.body);
      } else {
        LoadingIndicatorPopup.show(context, false);
        ErrorDialog.show(context,
            'Failed to fetch Cities By District data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      LoadingIndicatorPopup.show(context, false);
      ErrorDialog.show(context,
          'An error occurred while fetching Cities By District data: $e');
    }
  }

  getMetroCities(context) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + 'metroCities'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<MetroCity> metroCities = [];

        for (var item in jsonData['totalMetroCities']) {
          metroCities.add(MetroCity.fromJson(item));
        }

        return metroCities;
      } else {
        // Show error message
        ErrorDialog.show(context, 'Failed to load metro cities ');
      }
    } catch (error) {
      LoadingIndicatorPopup.show(context, false);
      ErrorDialog.show(context, error.toString());
    }
  }

  Future<CombinedUserData> fetchUserData(
      {required int phoneNumber, context}) async {
    LoadingIndicatorPopup.show(context, true);

    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'admin/search?phoneNumber=$phoneNumber'),
      );
      print(response.statusCode);
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        LoadingIndicatorPopup.show(context, false);

        if (responseData != null && responseData['data'] != null && responseData['data'].isNotEmpty) {
          CombinedUserData combinedUserData = CombinedUserData.fromJson(responseData['data'][0]);
          return combinedUserData;
        } else {
          throw Exception('Unexpected API response format');
        }
      } else {
        LoadingIndicatorPopup.show(context, false);
        ErrorDialog.show(context, 'Failed to load data');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      LoadingIndicatorPopup.show(context, false);
      ErrorDialog.show(context, 'An error occurred: $e');
      throw Exception('An error occurred: $e');
    }
  }


  getBusinessUserByDate(startDate,endDte,context)async{
    LoadingIndicatorPopup.show(context, true);

    try {
      final response = await http.get(Uri.parse(baseUrl+'admin/getBusinessUsersBydate',),);
      if (response.statusCode == 200) {
        LoadingIndicatorPopup.show(context, false);

        final Map<String, dynamic> responseData = json.decode(response.body);
        return BusinessByDate.fromJson(responseData);
      }else if(response.statusCode == 404){
        LoadingIndicatorPopup.show(context, false);
        ErrorDialog.show(context, 'Users not found for the provided date');
      }

    } catch (error) {

      ErrorDialog.show(context, 'Users not found for the provided date');
    }
  }


}


