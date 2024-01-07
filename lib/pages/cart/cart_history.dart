

import 'dart:convert';

import 'package:e_commercee_app/base/no_data_page.dart';
import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/models/cart_model.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/app_icon.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:e_commercee_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var listCounter = 0;
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    print(getCartHistoryList.length);
    Map<String, int> cartItemPerOrder = Map();

    for (int i =0; i< getCartHistoryList.length; i++){
      if(cartItemPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemPerOrderToList(){
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemPerOrderToList();
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyy hh:mm a");
        outputDate = outputFormat.format(inputDate);

      }
      return BigText(text: outputDate);
    }


    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimenstions.height10*10,
            color: Colors.teal[400],
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimenstions.height15*3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Your Cart History", color: Colors.white),
                AppIcon(icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.green20,
                  backgroundColor: Colors.transparent,
                  iconSize: 30,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cardController){
            return itemsPerOrder.isNotEmpty?
                 Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: Dimenstions.height20,
                      left: Dimenstions.width20,
                      right: Dimenstions.width20),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context, child:
                  ListView(
                    children: [
                      for (int i = 0; i< itemsPerOrder.length; i++)
                        Container(
                          height: Dimenstions.height10*12,
                          margin: EdgeInsets.only(bottom: Dimenstions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // BigText(text: getCartHistoryList[listCounter].time!),
                              timeWidget(listCounter),
                              SizedBox(height: Dimenstions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index) {

                                      print(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + getCartHistoryList[listCounter].img!);
                                      return index<=2? Container(
                                        height: Dimenstions.height20*4,
                                        width: Dimenstions.height20*4,
                                        margin: EdgeInsets.only(right: Dimenstions.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimenstions.radius20/2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL + AppConstants.UPLOAD_URL + getCartHistoryList[listCounter++].img!
                                                )
                                            )
                                        ),
                                      ): Container();
                                    }),
                                  ),
                                  Container(

                                    height: Dimenstions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total"),
                                        BigText(text: itemsPerOrder[i].toString()+ " Items", color: AppColors.neutral90),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for (int j = 0; j< getCartHistoryList.length; j++){
                                              if(getCartHistoryList[j].time == orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10,
                                                vertical: Dimenstions.height10/2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimenstions.radius30/10),
                                              border: Border.all(width: 1, color: Colors.teal[400]!),
                                            ),
                                            child: SmallText(text: "Order again",color: Colors.teal[400]!),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),)
              ),
            )
                :SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
                  child: const Center(child: const NoDataPage(text: "You didn't buy anything")),
                );
          })
        ],
      ),
    );
  }
}
