import 'package:e_commercee_app/base/show_custom_snackbar.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiChecker{
  static void checkApi(http.Response response){
    if(response.statusCode == 401){
      Get.offNamed(RouteHelper.getSignInPage());
    }
    else{
      showCustomSnackBar("Error Api Checked");
    }
  }
}
