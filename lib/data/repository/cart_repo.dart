import 'dart:convert';

import 'package:e_commercee_app/models/cart_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory= [];

  void addToCartList(List<CartModel> cartList){
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove("cart-history-list");
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> cart=[];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST))
    {
    cart = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];

    cart.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    // cart.forEach((element) =>
    //   CartModel.fromJson(jsonDecode(element))
    // );

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey("cart-history-list")){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList("cart-history-list")!;
    }
    List<CartModel> cartListHistory =[];
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }

  void addToCartHistoryList(){
    cartHistory = [];
    if(sharedPreferences.containsKey("cart-history-list")){
      cartHistory = sharedPreferences.getStringList("cart-history-list")!;
      print(cartHistory.length);
    }
    for (int i =0; i< cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList("cart-history-list", cartHistory);
  }

  void removeCart() {
    cart=[];
    sharedPreferences.remove("cart-history-list");

  }
  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove("cart-history-list");
  }

  void removeCartSharedReference() {
    sharedPreferences.remove(AppConstants.CART_LIST);


  }

}