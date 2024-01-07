
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiClientFirebase{
  final FirebaseFirestore db;


  const ApiClientFirebase({required this.db});

  Future<Map<String, dynamic>?>? getDataFirebase(String collection, {String? docs}) async {
    Map<String, dynamic>? data = new Map();
    if(docs!=null) {
      final docSnap = await db.collection(collection).doc(docs).get();
      data = docSnap.data();
      print(data);
  }
    else{
      final snap = await db.collection(collection).get();
      for (var item in snap.docs){
        data.putIfAbsent(item.id, () => item.data());
        print('${item.id} => ${item.data()}');
      }
    }
    return data;
  }
  Future<dynamic> getAllDocFromSubCollection(String collection, String docs, String subCollection) async {
    Map<String, dynamic>? data = new Map();
    final docRef = db.collection(collection).doc(docs).collection(subCollection);
    final snap = await docRef.get();
    for( var item in snap.docs){
      data.putIfAbsent(item.id, () => item.data());
    }
    return data;

  }

  Future<dynamic> getCustomDataFirebase(String collection, fromFirestore, toFirestore, {String? docs}) async {
    final dbRef = db.collection(collection)
        .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore);
    if(docs!=null){
      final docSnap = await dbRef.doc(docs).get();
      return docSnap.data();
    }
    else{
      Map<String, dynamic>? data = new Map();
      final snap = await dbRef.get();
      for(var item in snap.docs){
        data.putIfAbsent(item.id, () => item.data());
      }
      return data;
    }
  }


  Future<void> executePostData(dynamic dbRef,data) async {
    try{
      print(data.length.toString() + "length data");
      if(data is List)
      {
        for(var dataItem in data){
          await dbRef.add(dataItem);
          print("set dataItem");
        }
        print("data is list");
      }
      else{
        await dbRef.add(data);
        print("data is not list");
      }
      print("set data successful");
    }catch(e){
      print(e.toString());
    }
  }


  Future<void> postData(String collection, data) async {
    var dbRef = db.collection(collection);
    print(data.length);
    await executePostData(dbRef, data);
  }
  Future<void> postDataWithDocs(String collection, String? docs, data) async {
    var dbRef = db.collection(collection).doc(docs);
    print(data.length);
    await dbRef.set(data);
  }

  Future<void> postCustomData(String collection, data, fromFirestore, toFirestore )async {
    var dbRef = db.collection(collection).withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore);
    print(data.length.toString() + " number length data posted");
    await executePostData(dbRef, data);
  }
  Future<void> postDataIntoCollectionInDocs(String collection, String docs, String subCollection,data, {String? subdocs}) async {
    var dbRef = db.collection(collection).doc(docs).collection(subCollection).doc(subdocs);
    await dbRef.set(data);
  }



}