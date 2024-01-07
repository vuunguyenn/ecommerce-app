import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercee_app/data/api/api_client.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/models/products_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  // final ApiClient apiClient;
  // RecommendedProductRepo({required this.apiClient});
  // Future<Response> getRecommendedProductList() async{
  //   return await apiClient.getData(AppConstants.RECOMMENED_PRODUCT_URL);
  // }

  final ApiClientFirebase apiClientFirebase;
  RecommendedProductRepo({required this.apiClientFirebase});

  Future<Map<String, dynamic>?> getRecommendedProductFirebase() async {
    final fromFirestore = ProductModel.fromFirestore;
    toFirestore(dynamic product, SetOptions? options){
      return product.toFirestore as Map<String, dynamic>;
    }
    return await apiClientFirebase.getCustomDataFirebase(AppConstants.RECOMMENDED_PRODUCT_COLLECTION, fromFirestore, toFirestore);
  }




}
//http://mvs.bslmeiyu.com/api/v1/products/popular