import 'package:e_commercee_app/base/common_text_button.dart';
import 'package:e_commercee_app/base/no_data_page.dart';
import 'package:e_commercee_app/controllers/auth_controller.dart';
import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/controllers/location_controller.dart';
import 'package:e_commercee_app/controllers/order_controller.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/controllers/recommended_product_controller.dart';
import 'package:e_commercee_app/helper/helper_notification.dart';
import 'package:e_commercee_app/models/cart_model.dart';
import 'package:e_commercee_app/models/order_model.dart';
import 'package:e_commercee_app/models/payment_model.dart';
import 'package:e_commercee_app/pages/home/main_food_page.dart';
import 'package:e_commercee_app/pages/order/delivery_option.dart';
import 'package:e_commercee_app/pages/payment/payment_page.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/untils/style/font.dart';
import 'package:e_commercee_app/widgets/app_column.dart';
import 'package:e_commercee_app/widgets/app_icon.dart';
import 'package:e_commercee_app/widgets/app_text_field.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:e_commercee_app/pages/order/payment_option_button.dart';
import 'package:e_commercee_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String currency = "USD";
    final TextEditingController _textEditingController =
        TextEditingController();
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 20 * 2,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back,
                      iconColor: Colors.white,
                      backgroundColor: Colors.teal[400]!,
                      iconSize: 20,
                    ),
                    SizedBox(width: Dimenstions.width20 * 5),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: Colors.teal[400]!,
                        iconSize: 24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: Colors.teal[400]!,
                      iconSize: 24,
                    )
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: 20 * 5,
                      left: 20,
                      right: 20,
                      bottom: 0,
                      child: Container(
                          // color: Colors.red,
                          margin: EdgeInsets.only(top: Dimenstions.height15),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: (cartController) {
                              var cartList = cartController.getItems;
                              return ListView.builder(
                                  itemCount: cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      width: double.maxFinite,
                                      height: 100,
                                      margin: EdgeInsets.only(
                                          bottom: Dimenstions.height10),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(
                                                      cartList[index].product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cartpage"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(cartList[index]
                                                        .product!);
                                                //
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "history product",
                                                      "not available");
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartpage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 20 * 5,
                                              height: 20 * 5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOAD_URL +
                                                              cartController
                                                                  .getItems[
                                                                      index]
                                                                  .img!)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimenstions.radius20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: Dimenstions.width10),
                                          Expanded(
                                              child: Container(
                                            height: Dimenstions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                    text: cartController
                                                        .getItems[index].name!,
                                                    color: Colors.black, size: 20,),
                                                SmallText(text: "Spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                        text: "\$${cartController
                                                            .getItems[index]
                                                            .price!}",
                                                        color:
                                                            Colors.redAccent),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 1,
                                                          bottom: 1,
                                                          left: 10,
                                                          right: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .neutral90,

                                                              )),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          BigText(
                                                            text:
                                                                cartList[index]
                                                                    .quantity
                                                                    .toString(),
                                                            color: AppColors
                                                                .neutral90,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .neutral90,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    );
                                  });
                            }),
                          )))
                  : NoDataPage(text: "Your cart is empty");
            }),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<OrderController>(builder: (orderController) {
          _textEditingController.text = orderController.note;
          return GetBuilder<CartController>(builder: (cartController) {
            final isEmpty = cartController.getItems.length == 0;
            return Container(
              height: Dimenstions.screenHeight*0.23,
              padding: EdgeInsets.only(
                  top: Dimenstions.height10,
                  bottom: Dimenstions.height10,
                  left: Dimenstions.width20,
                  right: Dimenstions.width20),
              decoration: BoxDecoration(
                  color: isEmpty? AppColors.white : AppColors.neutral20,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: !isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: Dimenstions.height15),
                        InkWell(
                            onTap: () => showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (_) {
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                Dimenstions
                                                                    .radius20),
                                                        topRight:
                                                            Radius.circular(
                                                                Dimenstions
                                                                    .radius20))),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 520,
                                                      padding: EdgeInsets.only(
                                                          left: Dimenstions
                                                              .width20,
                                                          right: Dimenstions
                                                              .width20,
                                                          top: Dimenstions
                                                              .height20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          PaymentOptionButton(
                                                            icon: Icons.money,
                                                            title:
                                                                "Cash on delivery",
                                                            subTitle:
                                                                "You pay after getting the delivery",
                                                            index: 0,
                                                          ),
                                                          SizedBox(
                                                              height: Dimenstions
                                                                  .height10),
                                                          PaymentOptionButton(
                                                            icon: Icons
                                                                .payment_outlined,
                                                            title:
                                                                "Digital payment",
                                                            subTitle:
                                                                "Safer and faster way of payment",
                                                            index: 1,
                                                          ),
                                                          SizedBox(
                                                              height: Dimenstions
                                                                  .height20),
                                                          Text(
                                                            "Delivery options",
                                                            style: robotoMedium,
                                                          ),
                                                          SizedBox(
                                                              height: Dimenstions
                                                                      .height10 /
                                                                  2),
                                                          DeliveryOptions(
                                                              value: "delivery",
                                                              title:
                                                                  "home delivery",
                                                              amount: double.parse(Get
                                                                      .find<
                                                                          CartController>()
                                                                  .totalAmount
                                                                  .toString()),
                                                              isFree: false),
                                                          SizedBox(
                                                              height: Dimenstions
                                                                  .height10),
                                                          DeliveryOptions(
                                                              value:
                                                                  "take away",
                                                              title:
                                                                  "take away",
                                                              amount: 10.0,
                                                              isFree: true),
                                                          SizedBox(
                                                              height: Dimenstions
                                                                  .height20),
                                                          Text(
                                                              "Additional notes",
                                                              style:
                                                                  robotoMedium),
                                                          AppTextField(
                                                              textEditingController:
                                                                  _textEditingController,
                                                              hintText: '',
                                                              maxLines: true,
                                                              icon: Icons.note),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                .whenComplete(() => orderController.setFoodNote(
                                    _textEditingController.text.trim())),

                            child: SizedBox(
                              width: double.maxFinite,
                              child: CommonTextButton(text: "Payment options", color: Colors.teal[400]!,),
                            )),
                        SizedBox(height: Dimenstions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: Dimenstions.width10),
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimenstions.height15,horizontal: Dimenstions.width20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimenstions.radius20),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  BigText(
                                    text: "\$ " +
                                        cartController.totalAmount.toString(),
                                    color: AppColors.neutral90,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    if(Get.find<LocationController>().addressList.isEmpty)
                                      {
                                        Get.toNamed(RouteHelper.getAddressPage());
                                      }else {
                                      final amount = getAmount(
                                          cartController.totalAmount, currency);
                                      final itemList = processItemList(
                                          cartController.getItems, currency);
                                      final paymentMethod = processPaymentMethod(
                                          orderController.paymentIndex);
                                      final orderType = processOrderType(
                                          orderController.orderType);
                                      final note = orderController.note;
                                      final orderModel = OrderModel(
                                          amount: amount,
                                          itemList: itemList,
                                          paymentMethod: paymentMethod,
                                          orderType: orderType,
                                          note: note);
                                      if (paymentMethod == "Cash on delivery") {
                                        final isSuccess = await orderController
                                            .postOrderList(orderModel);

                                          final fCMToken = Get
                                              .find<HelperNotification>()
                                              .fCMToken;
                                          orderController.postNotification(
                                              isSuccess, fCMToken);
                                          print("isSuccess$isSuccess");
                                          if(isSuccess) showSnackBarSuccessful();

                                      }
                                      else {
                                        Get.toNamed(
                                            RouteHelper.getPaymentPage(),
                                            arguments: PaymentPage(
                                                orderModel: orderModel));
                                      }
                                    }
                                  } else {
                                    Get.toNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: CommonTextButton(
                                  text: 'Check out',
                                )),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            );
          });
        }));
  }

  Map<String, dynamic> getAmount(int totalAmount, String currency) {
    return {
      "total": totalAmount.toString(),
      "currency": currency,
      "details": {
        "subtotal": totalAmount.toString(),
        "shipping": '0',
        "shipping_discount": 0
      }
    };
  }

  List<PaymentModel> processItemList(List<CartModel> getItems, String currency) {
    final paymentModelList =
    getItems.map((e) => e.mapToPayment(currency)).toList();
    return paymentModelList;
  }

  String processPaymentMethod(int paymentIndex) {
    return paymentIndex == 0 ? "Cash on delivery" : "Digital payment";
  }

  String processOrderType(String orderType) {
    if(orderType == "delivery") return "Home delivery";
    return "Take away";

  }
}

void showSnackBarSuccessful() {
  const title = "Successfully";
  const message = "Payment success";
  Get.find<CartController>().clear();
  Get.find<CartController>().removeCartSharedReference();
  Get.find<CartController>().addToHistory();
  // Get.snackbar(title, message,
  //     titleText: BigText(text: title, color: Colors.black),
  //     messageText: const Text(
  //       message,
  //       style: TextStyle(color: Colors.black),
  //     ),
  //     colorText: Colors.black,
  //     snackPosition: SnackPosition.TOP,
  //     backgroundColor: Colors.transparent);
}

