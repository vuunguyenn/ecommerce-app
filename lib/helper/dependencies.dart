import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercee_app/controllers/auth_controller.dart';
import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/controllers/location_controller.dart';
import 'package:e_commercee_app/controllers/order_controller.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/controllers/recommended_product_controller.dart';
import 'package:e_commercee_app/controllers/user_controller.dart';
import 'package:e_commercee_app/data/api/api_client.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/data/repository/auth_repository.dart';
import 'package:e_commercee_app/data/repository/cart_repo.dart';
import 'package:e_commercee_app/data/repository/custom_repo.dart';
import 'package:e_commercee_app/data/repository/location_repo.dart';
import 'package:e_commercee_app/data/repository/order_repo.dart';
import 'package:e_commercee_app/data/repository/popular_product_repo.dart';
import 'package:e_commercee_app/data/repository/recommended_product_repo.dart';
import 'package:e_commercee_app/data/repository/user_repo.dart';
import 'package:e_commercee_app/helper/helper_notification.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  final firebaseFirestore = await FirebaseFirestore.instance;
  final firebaseAuth = await FirebaseAuth.instance;
  final firebaseMessaging = await FirebaseMessaging.instance;

  Get.lazyPut(() => firebaseMessaging);
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => firebaseFirestore);
  Get.lazyPut(() => firebaseAuth);

  Get.lazyPut(() => ApiClientFirebase(db: Get.find()));
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_OWN_SERVER), fenix: true);

  Get.lazyPut(() => HelperNotification(firebaseMessaging: Get.find()));

  Get.lazyPut(() => AuthRepository(apiClientFirebase: Get.find(), sharedPreferences: Get.find(), firebaseAuth: Get.find()));
  Get.lazyPut(() => UserRepo(firebaseAuth: Get.find()));
  // Get.lazyPut(()=> CustomRepo());
  Get.lazyPut(() => PopularProductRepo(apiClientFirebase: Get.find()));

  Get.lazyPut(() => RecommendedProductRepo(apiClientFirebase: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(),apiClientFirebase: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(),apiClientFirebase: Get.find(), sharedPreferences: Get.find()), fenix: true);

  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()), fenix: true);

}