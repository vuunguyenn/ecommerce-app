
import 'package:e_commercee_app/base/custom_app_bar.dart';
import 'package:e_commercee_app/controllers/auth_controller.dart';
import 'package:e_commercee_app/controllers/order_controller.dart';
import 'package:e_commercee_app/pages/order/view_order.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  late TabController _tabController;
  late bool _isLoggedIn;


  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "My orders", backButtonExist: false),
      body: _isLoggedIn ? Column(
        children: [
          Container(
            width: Dimenstions.screenWidth,

            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: [
                Tab(text: "Current"),
                Tab(text: "History")
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: const [
                  ViewOrder(isCurrent: true),
                  ViewOrder(isCurrent: false),
            ]),
          )
        ],
      ):
      Container(child: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          height: Dimenstions.height20*9,
          margin: EdgeInsets.only(left: Dimenstions.width20, right:  Dimenstions.width20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimenstions.radius20),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "assets/images/signintocontinue.jpg"
                  )
              )
          ),
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getSignInPage());
          },
          child: Container(
            width: double.maxFinite,
            height: Dimenstions.height20*3,
            margin: EdgeInsets.only(left: Dimenstions.width20*2, right:  Dimenstions.width20*2, top: Dimenstions.height20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimenstions.radius20),
                color: AppColors.green60
            ),
            child: Center(
              child: BigText(
                text: "Sign in", color: AppColors.neutral10,
              ),
            ),
          ),
        ),
      ],
    ))),
    );
  }
}
