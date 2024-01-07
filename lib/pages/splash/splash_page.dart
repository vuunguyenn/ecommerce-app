
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/controllers/recommended_product_controller.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/data/repository/custom_repo.dart';
import 'package:e_commercee_app/models/products_model.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    _loadResource();
    super.initState();
    controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 2))
        ..forward();

    animation = CurvedAnimation(parent: controller,
        curve: Curves.linear);

    Timer(
      Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/images/food.jpg",width: Dimenstions.splashImg))),
          Center(child: Image.asset("assets/images/food.jpg",width: Dimenstions.splashImg)),
        ],
      ),
    );
  }


  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductFirebase();
    await Get.find<RecommendedProductController>().getRecommenedProductFirebase();
  }
}
