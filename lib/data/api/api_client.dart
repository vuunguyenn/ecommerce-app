import 'dart:convert';

import 'package:http/http.dart' as http;

// class ApiClient extends GetConnect implements GetxService{
//   String? token;
//   final String appBaseUrl;
//   late Map<String, String> _mainHeader;
//   // late SharedPreferences sharedPreferences;
//
//   ApiClient({ required this.appBaseUrl}){
//     baseUrl = appBaseUrl;
//     timeout = Duration(seconds: 30);
//     // token= sharedPreferences.getString(AppConstants.TOKEN)??"";
//     _mainHeader={
//       'Content-type' : 'application/json; charset=UFT-8',
//       'Authorization': 'Bearer $token',
//     };
//   }
//   Future<Response> getData(String uri , {Map<String, String>? headers}) async {
//     try{
//       Response response = await get(uri,
//       headers: headers??_mainHeader);
//       print(appBaseUrl + uri);
//       return response;
//     }catch(e){
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//
//   }
//   void updateHeader(String token){
//     _mainHeader={
//       'Content-type' : 'application/json; charset=UFT-8',
//       'Authorization': 'Bearer $token',
//     };
//   }
//
//   Future<Response> postData(String uri, dynamic body) async {
//     try{
//       Response response = await post(uri, body, headers: _mainHeader);
//       return response;
//     }catch(e){
//       print(e.toString());
//       return Response(statusCode:  1, statusText: e.toString());
//     }
//   }
//
// }

class ApiClient{
  String? token;
  final String appBaseUrl;
  late Map<String, String> _mainHeader;

  ApiClient({ required this.appBaseUrl}){
    //timeout = Duration(seconds: 30);
    // token= sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeader={
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  Future<http.Response> getData(String url , {Map<String, String>? headers}) async {
    try{
      final uri = Uri.parse(url);
      print(uri);
      final response = await http.get(uri,
          headers: headers??_mainHeader);
      return response;
    }catch(e){
      print("error");
      return http.Response(e.toString(), 1);
    }
  }
  void updateHeader(String token){
    _mainHeader={
      'Content-type' : 'application/json; charset=UFT-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> postData(String url, dynamic body) async {
    try{
      Uri uri = Uri.parse(url);
      String data = jsonEncode(body);
      final response = await http.post(uri, body: data, headers: _mainHeader);
      return response;
    }catch(e){
      print(e.toString());
      return http.Response(e.toString(), 1);
    }
  }

}