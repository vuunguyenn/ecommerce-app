
import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/controllers/recommended_product_controller.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/data/repository/custom_repo.dart';
import 'package:e_commercee_app/helper/helper_notification.dart';
import 'package:e_commercee_app/pages/cart/cart_page.dart';
import 'package:e_commercee_app/pages/food/popular_food_detail.dart';
import 'package:e_commercee_app/pages/food/recommended_food_detail.dart';
import 'package:e_commercee_app/pages/home/food_page_body.dart';
import 'package:e_commercee_app/pages/home/main_food_page.dart';
import 'package:e_commercee_app/pages/splash/splash_page.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart'as dep;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dep.init();
  await Get.find<HelperNotification>().initNotifications();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.find<CartController>().getCartData();


    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          theme: ThemeData(
            primaryColor: AppColors.green70,

          ),
        );
      });
    });


  }
}
