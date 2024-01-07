

import 'package:e_commercee_app/data/api/api_client.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/models/address_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
  final ApiClientFirebase apiClientFirebase;
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClientFirebase, required this.sharedPreferences, required this.apiClient});

  Future<http.Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.BASE_OWN_SERVER}/${AppConstants.GEOCODE_URI}?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }
  String? getUserId(){
    return sharedPreferences.getString(AppConstants.USER_ID);
  }

  Future<dynamic> addAddress(AddressModel addressModel) async {
     String? uid = await getUserId();
    print(uid);
    if(uid == null) return false;
    await apiClientFirebase.postDataIntoCollectionInDocs("USER", uid, "ADDRESS",  addressModel.toJson(), subdocs: addressModel.addressType);
    return true;
  }
  Future<dynamic> getAllAddress() async {
    String? uid = await getUserId();
    if(uid == null) return null;
    return await apiClientFirebase.getAllDocFromSubCollection("USER", uid, "ADDRESS");

  }

  Future<bool> saveUserAddress(String address) async {
    // apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }
  
  Future<dynamic> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.BASE_OWN_SERVER}${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<dynamic> searchLocation(String text) async {
    return await apiClient.getData('${AppConstants.BASE_OWN_SERVER}${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }
  Future<dynamic> setLocation(String placeId) async {
    return await apiClient.getData('${AppConstants.BASE_OWN_SERVER}${AppConstants.PLACE_DETAIL_URI}?placeid=$placeId');
  }

}