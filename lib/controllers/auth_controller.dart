
import 'package:e_commercee_app/data/repository/auth_repository.dart';
import 'package:e_commercee_app/models/response_model.dart';
import 'package:e_commercee_app/models/signup_body_model.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// class AuthController extends GetxController implements GetxService{
//   final AuthRepository authRepo;
//   AuthController({
//     required this.authRepo
// });
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   Future<ResponseModel> registration(SignUpBody signUpBody) async {
//     _isLoading = true;
//     update();
//     Response response = await authRepo.registration(signUpBody);
//     late ResponseModel responseModel;
//     if(response.statusCode == 200){
//       authRepo.saveUserToken(response.body["token"]);
//       responseModel = ResponseModel(true, response.body["token"]);
//
//     }else{
//       responseModel = ResponseModel(false, response.statusText!);
//     }
//     _isLoading = false;
//     update();
//     return responseModel;
//   }
//
//   Future<ResponseModel> login(String email, String password) async {
//     // authRepo.getUserToken();
//     _isLoading = true;
//     update();
//     Response response = await authRepo.login(email, password);
//     late ResponseModel responseModel;
//     if(response.statusCode == 200){
//       authRepo.saveUserToken(response.body["token"]);
//       responseModel = ResponseModel(true, response.body["token"]);
//     }else{
//       responseModel = ResponseModel(false, response.statusText!);
//     }
//     _isLoading = false;
//     update();
//     return responseModel;
//
//   }
//
//   void saveUserNumberAndPassword(String number, String password) {
//     authRepo.saveUserNumberAndPassword(number, password);
//   }
//
//   bool userLoggedIn() {
//     return authRepo.userLoggedIn();
//   }
//
//   bool clearSharedData(){
//     return authRepo.clearSharedData();
//   }
//
// }

class AuthController extends GetxController implements GetxService{
  final AuthRepository authRepo;
  AuthController({
    required this.authRepo
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    User? user = await authRepo.signUpWithEmail(signUpBody);
    late ResponseModel responseModel;

    if(user!=null) responseModel = ResponseModel(true, "sign up successful");
    else responseModel = ResponseModel(false, "sign up failure");
    _isLoading = false;
    update();

    return responseModel;

    // if(response.statusCode == 200){
    //   authRepo.saveUserToken(response.body["token"]);
    //   responseModel = ResponseModel(true, response.body["token"]);
    //
    // }else{
    //   responseModel = ResponseModel(false, response.statusText!);
    // }



  }

  Future<ResponseModel> login(String email, String password) async {
    // authRepo.getUserToken();
    _isLoading = true;
    update();
    User? user = await authRepo.signInWithEmail(email, password);
    late ResponseModel responseModel;

    if(user!=null) responseModel = ResponseModel(true, "sign in successful");
    else responseModel = ResponseModel(false, "sign in failure");
    _isLoading = false;
    update();
    return responseModel;

  }
  bool userLoggedIn() {
     return authRepo.userLoggedIn();
   }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

  void signOut(){
    authRepo.signOut();
  }

}