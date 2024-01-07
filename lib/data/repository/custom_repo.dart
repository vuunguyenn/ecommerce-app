
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/controllers/recommended_product_controller.dart';
import 'package:e_commercee_app/models/products_model.dart';
import 'package:get/get.dart';

class CustomRepo{

  var docRefff;
  late Map<String, Product> data;

  void init(){
    final db = FirebaseFirestore.instance;
    docRefff = db
        .collection("Product")
        .withConverter(
      fromFirestore: ProductModel.fromFirestore,
      toFirestore: (ProductModel product, options) => product.toFirestore(),
    );
    print(db.toString() + "dbtostring");
  }


  Future<void> addDataToFirebase() async {
    var productRecommend = Get.find<RecommendedProductController>().recommendedProductList;
    var productPopular = Get.find<PopularProductController>().popularProductList;
    var productList = productPopular + productRecommend;
    print("recommend" + productRecommend.length.toString() + productPopular.length.toString());
    try{
      for (var item in productList){
        await docRefff.add(item);
      }
      print("successful");
    }
    catch(e){
      print("error add data"+e.toString());
    }
  }

    Future<void> getDataFirebase() async {
    data = new Map();
     await docRefff.get().then(
          (querySnapshot){
            for (var item in querySnapshot.docs){
              data.putIfAbsent(item.id, () => item.data());
              print('${item.id} => ${item.data()}');
              // item.data().showConsole();
            }
          },
        onError: (e)=> print(e.toString() + "error"),
      );
    docRefff.snapshots().listen(
          (event) => event.docs.forEach((e){
            print("object " + e.data().toString());
          }),
      onError: (error) => print("Listen failed: $error"),
    );
  }

    // Future<void> process() async {
    //   await getDataFirebase();
    //   updateDatabase(23);
    // }
    // void updateDatabase(int typeId){
    //     // print("datadata" + data.toString());
    //     var id = null;
    //     data.forEach((key, value) {
    //       // print(key + value.typeId.toString());
    //       if(value.typeId == typeId) id = key;
    //     });
    //     Product product = Product(totalSize: 2, typeId: 5, offset: 2, products: <ProductModel>[]);
    //     if(id!=null){
    //       docRefff.doc(id).update(product.toFirestore()).then(
    //               (value) => print("DocumentSnapshot successfully updated!"),
    //           onError: (e) => print("Error updating document $e"));
    //     }
    //     else{
    //
    //     }
    //
    //
    // }



}