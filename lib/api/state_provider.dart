import 'package:dailer_admin/api/post.dart';
import 'package:dailer_admin/api/update.dart';
import 'package:flutter/cupertino.dart';
import '../models/businessUserByDate.dart';
import '../models/category_model.dart';
import '../models/cities_by_name.dart';
import '../models/metrocities.dart';
import '../models/user_details.dart';
import 'delete.dart';
import 'get.dart';

class StateProvider extends ChangeNotifier {
  int index = 0;
  int userIndex = 0;
  TextEditingController field1Controller = TextEditingController();
  TextEditingController field2Controller = TextEditingController();
  TextEditingController field3Controller = TextEditingController();
  var allDistricts2 = ['Select District'];
  List<CitiData> allCitiesData2 = [];
  List<Datum> user = [];
  List<CombinedUserData> combinedUserData = [];

  userPhoneSearchApi(BuildContext context,int number)async{
    combinedUserData.clear();
    CombinedUserData combinedUserDetails =  await GetApi().fetchUserData(phoneNumber: number,context:context);
    combinedUserData.add(combinedUserDetails);
    notifyListeners();
  }
  getDistricts2( {context, stateName}) async {
    allCitiesData.clear();
    notifyListeners();
    allDistricts2.clear();
    allDistricts2.add('Select District');
    DistrictsData data =   await GetApi().getCitiesDistricts(stateName, context);
    for(int i = 0;i<data.totalDistricts.length;i++){
      allDistricts2.add(data.totalDistricts[i]);
      notifyListeners();
    }
  }

  getCities2({context, districtName}) async {
    allCitiesData2.clear();
    notifyListeners();
    var data  = await GetApi().getCitiesByDistrict(districtName, context);
    var final_dta = data['totalcities'];
    for(var i = 0;i<final_dta.length;i++){
      var a= CitiData.fromJson(final_dta[i]);
      allCitiesData2.add(a);
      notifyListeners();
    }

    var ids = Set<CitiData>();
    allCitiesData2.retainWhere((x) => ids.add(x));
    notifyListeners();
    allCitiesData2 = ids.toList();
    notifyListeners();
  }
  dashBoardUpdate(i) {
    index = i;
    notifyListeners();
  }
  dashBoardUpdate2(i) {
    userIndex = i;
    notifyListeners();
  }

  List<StatesData> allStates = [];
  var allDistricts = ['Select District'];
  List<CitiData> allCitiesData = [];
  List<Categories> categories = [];
  List<MetroCity> metroCities = [];

  allCities(context) async {
    var data = await GetApi().fetchCities(context);
    notifyListeners();
  }

  getCategory(context) async {
    categories = await GetApi().fetchCategoryData(context);
    notifyListeners();
  }

  createCategory({context, categoryName, subCategory, keyWords}) async {
     await PostApi().createCategory(
        categoryName: field1Controller.text,
        subCategory: field2Controller.text,
        keyWords: field3Controller.text,
        context: context).then((n){
      field1Controller.clear();
      field2Controller.clear();
      field3Controller.clear();
      getCategory(context);
    });

  }

  updateCategory({context, id, categoryName, subCategory, keyWords}) async {
    await UpdateApi().patchData(
        categoryId: id,
        categoryName: field1Controller.text,
        subCategory: field2Controller.text,
        keyWords: field3Controller.text,
        context: context).then((v){
      field1Controller.clear();
      field2Controller.clear();
      field3Controller.clear();
      getCategory(context);
    });
  }

  deleteCategory( {id, context}) async {

    await DeleteApi().deleteCategory(id, context).then((v) {
      categories.clear();

      categories.removeWhere((element) => element.id==id);
      notifyListeners();
    });
    await getCategory(context);

  }

  createCity({state, district, city, context}) async {
    await PostApi().createCity(
        state: field1Controller.text, district: field2Controller.text,
        city: field3Controller.text, context: context).then((n){
    });
  }

  updateCity({id, state, district, city, context}) async {
    await UpdateApi().updateCity(id.toString(),
        state: field1Controller.text, district: field2Controller.text,
        city: field3Controller.text, context: context);

  }

  deleteCity({id, context}) async {
    await DeleteApi().deleteCity(id, context).then((v) {
      allCitiesData.removeWhere((element) => element.id==id);
      notifyListeners();
    });

  }

  getMetroCities(context) async {
    metroCities = await GetApi().getMetroCities(context);
    notifyListeners();
  }

  createMetroCity({context}) async {
    await PostApi().createMetroCity(
        context: context,
      metroCity: field1Controller.text,
      subCity: field2Controller.text,).then((n){
      field1Controller.clear();
      field2Controller.clear();
      field3Controller.clear();
      getMetroCities(context);
    });

  }

  updateMetroCity({context, id}) async {
    await UpdateApi().updateMetroCity(
        context: context, metroCity: field1Controller.text,
        subCity: field2Controller.text,
        id: id
    ).then((v){
      field1Controller.clear();
      field2Controller.clear();
      field3Controller.clear();
      getMetroCities(context);
    });
  }

  deleteMetroCity({context, id}) async {
    await DeleteApi().deleteMetroCity(context: context, metroCityId: id).then((v) {
      metroCities.removeWhere((element) => element.id==id);
      notifyListeners();
    });
    getMetroCities(context);
  }

  getStates(context) async {
    allDistricts.clear();
    notifyListeners();
    allStates = await GetApi().getCitiesStates(context);
    notifyListeners();
  }

  getDistricts( {context, stateName}) async {
    allCitiesData.clear();
    notifyListeners();
    allDistricts.clear();
    allDistricts.add('Select District');
    DistrictsData data =   await GetApi().getCitiesDistricts(stateName, context);
    for(int i = 0;i<data.totalDistricts.length;i++){
      allDistricts.add(data.totalDistricts[i]);
      notifyListeners();
    }
  }

  getCities({context, districtName}) async {

    var data  = await GetApi().getCitiesByDistrict(districtName, context);
    var final_dta = data['totalcities'];
    for(var i = 0;i<final_dta.length;i++){
      var a= CitiData.fromJson(final_dta[i]);
      allCitiesData.add(a);
      notifyListeners();
    }
  }

  updateFields({field1Text,field2Text,field3Text}){
    field1Controller.text =  field1Text;
    field2Controller.text =  field2Text;
    field3Controller.text =  field3Text;
    notifyListeners();
  }

  updateFields2({field1Text,field2Text,field3Text}){
    field1Controller.text =  field1Text;
    field2Controller.text =  field2Text;
    notifyListeners();
  }

  getBusinessByDate(startDate,endDte,context)async{
    BusinessByDate data =  await GetApi().getBusinessUserByDate(startDate,endDte,context);
   user = data.data;
   notifyListeners();
  }
}
