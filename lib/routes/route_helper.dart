import 'package:e_commercee_app/pages/address/add_address_page.dart';
import 'package:e_commercee_app/pages/address/pick_address_map.dart';
import 'package:e_commercee_app/pages/auth/sign_in_page.dart';
import 'package:e_commercee_app/pages/cart/cart_page.dart';
import 'package:e_commercee_app/pages/food/popular_food_detail.dart';
import 'package:e_commercee_app/pages/food/recommended_food_detail.dart';
import 'package:e_commercee_app/pages/home/home_page.dart';
import 'package:e_commercee_app/pages/home/main_food_page.dart';
import 'package:e_commercee_app/pages/payment/payment_page.dart';
import 'package:e_commercee_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial= "/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap ="/pick-address";
  static const String payment = "/payment";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=> '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage({double? lat, double? long}) => '$addAddress?lat=${lat??0}&long=${long??0}';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage() => '$payment';

  static List<GetPage> routes=[
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
    } ,
    transition: Transition.fadeIn
    ),
    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!),page: page!);
  } ,
    transition: Transition.fadeIn),

    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn

  ),
    GetPage(name: signIn, page: (){
      return SignInPage();
    },
        transition: Transition.fade

    ),
    GetPage(name: addAddress, page: (){
      if(Get.parameters['lat'] != '0.0'&&Get.parameters['long']!='0.0')
      {
        double lat = double.parse(Get.parameters['lat']!);
        double long = double.parse(Get.parameters['long']!);
      return AddAddressPage(latLng: LatLng(lat, long));
      }
      return AddAddressPage();
    }),
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap _pickAddress = Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: payment, page: (){
      PaymentPage _paymentPage = Get.arguments;
      return _paymentPage;
    },
        transition: Transition.fade
    ),

  ];


}