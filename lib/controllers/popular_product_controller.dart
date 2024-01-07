import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/data/repository/popular_product_repo.dart';
import 'package:e_commercee_app/data/repository/product_repo.dart';
import 'package:e_commercee_app/models/cart_model.dart';
import 'package:e_commercee_app/models/products_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList=[];
  List<ProductModel> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity= 0;

  int get quantity => _quantity;
  int _inCartItem = 0;
  int get inCartItem => _inCartItem + _quantity;

  Map<int, CartModel> _items={};
  Map<int, CartModel> get items => _items;

  late CartController _cart;
  // Future<void> getPopularProductList() async {
  //   Response response = await popularProductRepo.getPopularProductList();
  //   if(response.statusCode==200){
  //     print("got products");
  //        _popularProductList=[];
  //        _popularProductList.addAll(Product.fromJson(response.body).products);
  //        update();
  //        _isLoaded= true;
  //   }else{
  //     print(response.toString());
  //     print("got products error");
  //   }
  // }

  Future<void> getPopularProductFirebase() async {
    final data = await popularProductRepo.getPopularProductFirebase();
    if(data == null) return;
    final product = data.entries.map<ProductModel>((e) => e.value);
    _popularProductList = [];
    _popularProductList.addAll(product);
    update();
    _isLoaded = true;
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      print('increment');
      _quantity = checkQuantity(_quantity + 1);
    }
    else{
      _quantity = checkQuantity(_quantity - 1) ;
    }
    update();
  }

  int checkQuantity(int quantity){
    if(_inCartItem + quantity < 0){
      if(_inCartItem > 0){
        _quantity =-_inCartItem;
        return _quantity;
      }
      return 0;
    }else if(_inCartItem + quantity > 20){
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(CartController cart, ProductModel product){
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if(exist){
      _inCartItem = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product){
    // if(_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
       _inCartItem = _cart.getQuantity(product);
      // _cart.items.forEach((key, value) {
      // });
    // }
    // else{
    //
    // }
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}