import 'package:e_commercee_app/data/repository/popular_product_repo.dart';
import 'package:e_commercee_app/data/repository/recommended_product_repo.dart';
import 'package:e_commercee_app/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});


  List<ProductModel> _recommendedProductList=[];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // Future<void> getRecommenedProductList() async {
  //   Response response = await recommendedProductRepo.getRecommendedProductList();
  //   if(response.statusCode == 200){
  //     print("got products recommended");
  //     _recommendedProductList=[];
  //     _recommendedProductList.addAll(Product.fromJson(response.body).products);
  //     update();
  //     _isLoaded= true;
  //   }else{
  //     print(response.toString());
  //     print("got products recommended error");
  //   }
  // }

  Future<void> getRecommenedProductFirebase() async {
    final data =  await recommendedProductRepo.getRecommendedProductFirebase();
    if(data == null) return;
    final products = data.entries.map<ProductModel>((e) => e.value);
    _recommendedProductList=[];
    _recommendedProductList.addAll(products);
    update();
    _isLoaded= true;
  }
}