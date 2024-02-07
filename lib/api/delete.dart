
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error.dart';
import '../models/category_model.dart';
import '../theme.dart';


class DeleteApi{
  Future deleteCategory(String categoryId,context) async {
    try{
      LoadingIndicatorPopup.show(context,true);
      final response = await http.delete(
        Uri.parse(baseUrl+'category/$categoryId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        LoadingIndicatorPopup.show(context,false);
        showSuccessPopup(context, "Deleted");
        return response.body;
      } else {
        LoadingIndicatorPopup.show(context,false);
        throw Exception('Failed to delete data. Status code: ${response.statusCode}');
      }
    }  catch (error) {
  // Show error message
  ErrorDialog.show(context, error.toString());
  LoadingIndicatorPopup.show(context, false);
  }
  }


 deleteCity(String cityId,context) async {
  try{ LoadingIndicatorPopup.show(context, true);
    final response = await http.delete(
      Uri.parse(baseUrl+'cities/$cityId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      LoadingIndicatorPopup.show(context, false);
      showSuccessPopup(context, "Deleted");

      return response.body;
    }
    else if (response.statusCode != 200) {
      LoadingIndicatorPopup.show(context,false);
      ErrorDialog.show(context,' Failed to delete city. Status code: ${response.statusCode}');
      LoadingIndicatorPopup.show(context, false);
    }
 } catch (error) {
  // Show error message
  ErrorDialog.show(context, error.toString());
  LoadingIndicatorPopup.show(context, false);

  }
  }


deleteMetroCity({metroCityId,context}) async {
   try{ LoadingIndicatorPopup.show(context, true);
    final response = await http.delete(
      Uri.parse(baseUrl+'metroCities/$metroCityId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      LoadingIndicatorPopup.show(context, false);
      showSuccessPopup(context, "Deleted");
      return response.body;
    }
    else if (response.statusCode != 200) {
      LoadingIndicatorPopup.show(context,false);
      ErrorDialog.show(context,' Failed to delete city. Status code: ${response.statusCode}');
    }
} catch (error) {
  // Show error message
  ErrorDialog.show(context, error.toString());
  LoadingIndicatorPopup.show(context, false);

  }
  }



 deleteRatingAndComment(context,String businessId, String userId,) async {

    try {
      LoadingIndicatorPopup.show(context,true);
      final response = await http.delete(
        Uri.parse(baseUrl+'admin/deleteCommentAndRating'), // Replace with your actual API endpoint
        headers: {
          'Content-Type': 'application/json',
          // Add any additional headers if needed
        },
        body: jsonEncode({
          "businessId": businessId,
          "userId": userId,
        }),
      );

      if (response.statusCode == 200) {
        LoadingIndicatorPopup.show(context,false);
        SuccessPopup(method: 'delete',);
        // Handle any other logic after a successful delete
      } else {
        LoadingIndicatorPopup.show(context,false);
        ErrorDialog.show(context,' Failed to delete . Status code: ${response.statusCode}');
        // Handle error cases
      }
    } catch (error) {
      ErrorDialog.show(context, error.toString());
      LoadingIndicatorPopup.show(context, false);
      // Handle error cases
    }
  }



}