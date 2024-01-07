
import 'dart:convert';

import 'package:e_commercee_app/data/api/api_client.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/models/order_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo{
  final ApiClientFirebase apiClientFirebase;
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  OrderRepo({required this.apiClient ,required this.apiClientFirebase, required this.sharedPreferences});

  String? getUserId(){
    return sharedPreferences.getString(AppConstants.USER_ID);
  }

  Future<dynamic> getOrderList() async {
    final userId = await getUserId();
    if(userId == null) return;
    return apiClientFirebase.getAllDocFromSubCollection("USER", userId, "ORDER");
  }


  Future<bool> postOrderList(OrderModel data) async {
    final userId = await getUserId();
    final dataIsProcessed = data.toJson();
    if(userId == null) return false;
    try{
      await apiClientFirebase.postDataIntoCollectionInDocs("USER", userId, "ORDER", dataIsProcessed);
      return true;
    }catch(e){
      print(e);
      return false;
    }

  }

  void postNotification(bool isSuccess, String token) async {

    apiClient.postData(apiClient.appBaseUrl + AppConstants.PUSH_NOTIFICATION, {"fCM Token":token, "isSuccess":isSuccess});
  }


}