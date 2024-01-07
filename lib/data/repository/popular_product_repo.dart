import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercee_app/data/api/api_client.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/data/repository/product_repo.dart';
import 'package:e_commercee_app/models/products_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  // final ApiClient apiClient;
  // PopularProductRepo({required this.apiClient});
  // Future<Response> getPopularProductList() async{
  //   return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  // }

  final ApiClientFirebase apiClientFirebase;
  PopularProductRepo({required this.apiClientFirebase});

  Future<Map<String, dynamic>?> getPopularProductFirebase() async {
    final fromFirestore = ProductModel.fromFirestore;
    toFirestore(dynamic product, SetOptions? options){
      return product.toFirestore() as Map<String, dynamic>;
    }
    return await apiClientFirebase.getCustomDataFirebase(AppConstants.POPULAR_PRODUCT_COLLECTION, fromFirestore, toFirestore);
  }

}
//http://mvs.bslmeiyu.com/api/v1/products/popular