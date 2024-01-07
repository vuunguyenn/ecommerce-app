
import 'package:e_commercee_app/data/repository/order_repo.dart';
import 'package:e_commercee_app/helper/helper_notification.dart';
import 'package:e_commercee_app/models/order_model.dart';
import 'package:e_commercee_app/models/payment_model.dart';
import 'package:get/get.dart';


class OrderController extends GetxController{
  final OrderRepo orderRepo;


  OrderController({required this.orderRepo});

  bool _isLoading = false;
  late List<PaymentModel> _currentOrderList;
  late List<PaymentModel> _historyOrderList;

  bool get isLoading => _isLoading;
  List<PaymentModel> get currentOrderList => _currentOrderList;
  List<PaymentModel> get historyOrderList => _historyOrderList;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _orderType = "delivery";
  String get orderType => _orderType;
  String _note = "";
  String get note => _note;

  Future<void> getOrderList() async{
    _isLoading = true;
    final response = await orderRepo.getOrderList();
    if(response != null){
      _historyOrderList = [];
      _currentOrderList = [];
      final orderList = response.entries.map((e) => e.value['itemList']).toList();
      orderList.forEach((order){
        order.forEach((item){
          PaymentModel paymentModel = PaymentModel.fromJson(item);
          if(paymentModel.status == "pending" ||
              paymentModel.status == "accepted"||
              paymentModel.status == "processing"||
              paymentModel.status == "handover"||
              paymentModel.status == "picked_up"){
            _currentOrderList.add(paymentModel);
          }else{
            _historyOrderList.add(paymentModel);
          }
        });
        });
    }else{
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;
    update();
  }
  Future<bool> postOrderList(OrderModel data) async{
     final isSuccess = await orderRepo.postOrderList(data);
    if(!isSuccess){
      print("error post order list to firebase");
    }
    return isSuccess;
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }
  void setDeliveryType(String type){
    _orderType = type;
    update();
  }

  void setFoodNote(String note){
    if(note == _note) return;
    _note = note;
    update();
  }

  void postNotification(bool isSuccess, String? token) {
    if(token == null) return;
    orderRepo.postNotification(isSuccess, token);


  }

}