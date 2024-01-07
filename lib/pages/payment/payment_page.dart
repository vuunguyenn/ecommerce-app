import 'package:e_commercee_app/controllers/order_controller.dart';
import 'package:e_commercee_app/helper/helper_notification.dart';
import 'package:e_commercee_app/models/order_model.dart';
import 'package:e_commercee_app/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';

class PaymentPage extends StatelessWidget {
  final OrderModel orderModel;
  const PaymentPage({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    const currency = "USD";
    final paymentModelList = orderModel.itemList.map((e) => e.toJson()).toList();
    final total = orderModel.amount["total"];
    final amount = {
      "total": total,
      "currency": currency,
      "details": {
        "subtotal": total,
        "shipping": '0',
        "shipping_discount": 0
      }
    };
    void successPayment() async{

      final isSuccess = await Get.find<OrderController>().postOrderList(orderModel);
        final fCMToken = Get
            .find<HelperNotification>()
            .fCMToken;
        Get.find<OrderController>().postNotification(
            isSuccess, fCMToken);
      if(isSuccess) showSnackBarSuccessful();
    }

    print(amount);

    return Scaffold(body:
       Center(
        child: PaypalCheckout(
          sandboxMode: true,
          clientId:
              "AbkqdNaqPwTWosC_ajPOFDVNHhgqCq7w9flqB9G0mhR-DLJtcqBnON3VJY9YXRusq3A4HBEauZ6sz0ic",
          secretKey:
              "ELg9b8eeHEXDtAaGJMIZ-niV-59eYXBFbPl5hieb4TM_7fjdowsHcczVmHCRu8QA7-YLUMrj-z0M7Pvk",
          returnURL: "success.com",
          cancelURL: "cancel.com",
          transactions: [
            {
              "amount": amount,
              "description": "The payment transaction description.",
              // "payment_options": {
              //   "allowed_payment_method":
              //       "INSTANT_FUNDING_SOURCE"
              // },
              "item_list": {
                "items": paymentModelList,

                // shipping address is not required though
                //   "shipping_address": {
                //     "recipient_name": "Raman Singh",
                //     "line1": "Delhi",
                //     "line2": "",
                //     "city": "Delhi",
                //     "country_code": "IN",
                //     "postal_code": "11001",
                //
                //     "state": "Texas"
                //  },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) {
            successPayment();
            print("onSuccess: $params");
          },
          onError: (error) {
            print("onError: $error");
            Navigator.pop(context);
          },
          onCancel: () {
            //Get.offNamed(RouteHelper.getInitial());
            print('cancelled:');
          },
        ),
      )
    );
  }

}
