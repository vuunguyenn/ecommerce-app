
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  int? get typeId => _typeId;
  int? get totalSize => _totalSize;
  int? get offset => _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;


  Product({required totalSize, required typeId, required offset, required products}){
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  void showConsole(){
    print(" totalSize " + this._totalSize.toString() + " typeId " + this._typeId.toString() + " offset " + this._offset.toString());
    for (var item in this._products){
      print(item);
    }
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }

  // factory Product.fromFirestore
  //     (DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options)
  // {
  //   final data = snapshot.data();
  //   return Product(
  //     totalSize: data?["totalSize"],
  //     typeId : data?["typeId"],
  //     offset: data?["offset"],
  //     products: data?["product"].map<ProductModel>((e) {
  //       print(e["id"]);
  //       return ProductModel.fromFirestore(e);
  //     }).toList()
  //   );
  //}

  // factory Product.fromSnapshot(data){
  //   return Product(totalSize: data.totalSize, typeId: data.typeId, offset: data.offset, products: data.products);
  // }


  // Map<String, dynamic> toFirestore(){
  //   return{
  //     if(_totalSize!=null) "totalSize": _totalSize,
  //     if(_typeId!=null) "typeId": _typeId,
  //     if(_offset!=null) "offset": _offset,
  //     if(_products!=null) "product": _products.map((e) => e.toFirestore())
  //   };
  // }

}

class ProductModel {
   int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      { this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId});

  factory ProductModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options)
  {
    final data = snapshot.data();
    return ProductModel(
      id: data?['id'],
      name: data?['name'],
      description: data?['description'],
      price: data?['price'],
      stars: data?['stars'],
      img: data?['img'],
      location: data?['location'],
      createdAt : data?['createdAt'],
      updatedAt : data?['updatedAt'],
      typeId : data?['typeId'],
    );
  }

  Map<String, dynamic> toFirestore(){
    return{
      if(id!=null) "id":id,
      if(name!=null) "name":name,
      if(description!=null) "description":description,
      if(price!=null) "price":price,
      if(stars!=null) "stars":stars,
      if(img!=null) "img":img,
      if(location!=null) "location":location,
      if(createdAt!=null) "createAt":createdAt,
      if(updatedAt!=null) "updateAt": updatedAt,
      if(typeId!=null) "typeid":typeId
    };
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson(){
    return{
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "location": this.location,
      "createAt": this.createdAt,
      "updateAt": this.updatedAt,
      "typeId": this.typeId
    };
  }
}