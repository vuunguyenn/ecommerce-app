import 'package:e_commercee_app/models/payment_model.dart';

class OrderModel {
  final Map<String, dynamic> amount;
  final List<PaymentModel> itemList;
  late String _paymentMethod;
  late String _orderType;
  late String _note;
  OrderModel(
      {required this.amount,
      required this.itemList,
      required String paymentMethod,
      required String orderType,
      required String note}) {
    _paymentMethod = paymentMethod;
    _orderType = orderType;
    _note = note;
  }

  Map<String, dynamic> toJson() {
    final itemListJson = itemList.map((e) => e.toJson()).toList();
    return {"amount": amount, "itemList": itemListJson,
      "orderType": _orderType, "paymentMethod": _paymentMethod, "note": _note
    };
  }
}
