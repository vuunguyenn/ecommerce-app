
import 'package:e_commercee_app/data/api/api_client.dart';
import 'package:e_commercee_app/data/api/api_client_firebase.dart';
import 'package:e_commercee_app/models/signup_body_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class AuthRepository{
//   final ApiClient apiClient;
//
//   AuthRepository({required this.apiClient, required this.sharedPreferences});
//
//   final SharedPreferences sharedPreferences;
//   Future<Response> registration(SignUpBody signUpBody) async {
//     return await apiClient.postData(AppConstants.APP_NAME, signUpBody.toJson());
//   }
//
//   Future<Response> login(String email, String password) async {
//     return await apiClient.postData(AppConstants.APP_NAME,
//         {'email' :email, 'password': password});
//   }
//
//   Future<bool> saveUserToken(String token) async {
//     apiClient.token = token;
//     apiClient.updateHeader(token);
//     return await sharedPreferences.setString(AppConstants.TOKEN, token);
//   }
//
//   Future<String> getUserToken() async {
//     return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
//   }
//   bool userLoggedIn() {
//     return sharedPreferences.containsKey(AppConstants.TOKEN);
//   }
//
//   Future<void> saveUserNumberAndPassword(String number, String password)async {
//     try{
//       await sharedPreferences.setString(AppConstants.PHONE, number);
//       await sharedPreferences.setString(AppConstants.PASSWORD, password);
//     }catch(e){
//       throw e;
//     }
//   }
//
//   bool clearSharedData(){
//     sharedPreferences.remove(AppConstants.TOKEN);
//     sharedPreferences.remove(AppConstants.PASSWORD);
//     sharedPreferences.remove(AppConstants.PHONE);
//     apiClient.token = '';
//     apiClient.updateHeader('');
//     return true;
//   }
//
// }

class AuthRepository extends GetxService{
  AuthRepository({required this.firebaseAuth, required this.sharedPreferences, required this.apiClientFirebase});
  final ApiClientFirebase apiClientFirebase;
  final FirebaseAuth firebaseAuth;
  final SharedPreferences sharedPreferences;


  Future<User?> signUpWithEmail(SignUpBody signUpBody) async {
    try {
      UserCredential? user = await firebaseAuth.createUserWithEmailAndPassword(
          email: signUpBody.email, password: signUpBody.password);
      apiClientFirebase.postDataWithDocs(
          "USER", user.user?.uid, {"email": signUpBody.email});
      firebaseAuth.currentUser!.updateDisplayName(signUpBody.name);
      await sharedPreferences.setString(AppConstants.USER_ID, user.user!.uid);
      return user.user;
    }
    catch(e){
      print("error signUp");
    }
    return null;
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try{
      UserCredential? user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await sharedPreferences.setString(AppConstants.USER_ID, user.user!.uid);
      // firebaseAuth.currentUser?.getIdToken().then(
      //         (token) async {
      //           if(token== null) return;
      //           apiClient.updateHeader(token);
      //           try{
      //             print("running");
      //             final response = await apiClient.getData(apiClient.appBaseUrl + AppConstants.GET_TOKEN);
      //             print("Custom token" + response.body);
      //           }catch(e){
      //             print(e);
      //           }
      //         });
      return user.user;
    }
    catch(e){
      print("error auth repo" + e.toString());
    }
    return null;
  }

  bool userLoggedIn() {
    return firebaseAuth.currentUser != null ? true: false;
  }

  bool clearSharedData(){
    return true;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();

  }
}