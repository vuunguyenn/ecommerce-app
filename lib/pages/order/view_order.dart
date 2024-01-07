import 'package:e_commercee_app/base/custom_loader.dart';
import 'package:e_commercee_app/controllers/order_controller.dart';
import 'package:e_commercee_app/models/payment_model.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/untils/style/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading == false) {
          late List<PaymentModel> orderList = [];
          if (orderController.currentOrderList.isNotEmpty) {
            orderList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimenstions.screenWidth,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimenstions.width10 / 2, vertical: Dimenstions.height10/2),
              child: ListView.builder(
                  itemCount:  orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(orderList[index].name!,),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.green70,
                                            borderRadius: BorderRadius.circular(
                                                Dimenstions.radius20 / 4)),
                                        padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10, vertical: Dimenstions.width10/2),
                                        child: Text(
                                          orderList[index].status,
                                          style: TextStyle(
                                              color: Theme.of(context).cardColor),
                                        )),
                                    SizedBox(height: Dimenstions.height10 / 2),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10, vertical: Dimenstions.width10/2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                Dimenstions.radius20 / 4),
                                        border: Border.all(width: 1, color: Theme.of(context).primaryColor)
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset("assets/images/tracking.png", height: 15, width: 15,
                                            color: Theme.of(context).primaryColor,),
                                            SizedBox(width: Dimenstions.width10/2),
                                            Text("Track order", style: robotoMedium.copyWith(
                                              fontSize: Dimenstions.font12,
                                              color: Theme.of(context).primaryColor
                                            ),),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimenstions.height10)
                        ],
                      ),
                    );
                  }),
            ),
          );
        } else {
          return CustomLoader();
        }
      }),
    );
  }
}
