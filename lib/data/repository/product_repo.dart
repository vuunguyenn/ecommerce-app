import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/models/products_model.dart';

class ProductRepo{
  late final Map<String, dynamic>? product;
  final List<ProductModel> recommendProduct = [];
  final List<ProductModel> popularProduct = [];
  final ApiClientFirebase api;
  ProductRepo({required this.api});

  Future<void> getProduct() async {
    product = await api.getDataFirebase("Product");
    categorizeRecommendedAndPopularProducts();
    print("category success");
  }

  List<ProductModel> getRecommendProduct(){
    return recommendProduct;
  }

  List<ProductModel> getPopularProduct(){
    return popularProduct;
  }

  void categorizeRecommendedAndPopularProducts() {
    var productModel = product!.entries.map<ProductModel>((e) => e.value);
    productModel.forEach((element) {
      if(element.typeId == 2) recommendProduct.add(element);
      else popularProduct.add(element);
    });
  }

}