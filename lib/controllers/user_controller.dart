
import 'package:e_commercee_app/data/repository/user_repo.dart';
import 'package:e_commercee_app/models/response_model.dart';
import 'package:e_commercee_app/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo
  });

  UserModel? _userModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    final user = await userRepo.getUserInfo();
    late ResponseModel responseModel;

    if(user == null) responseModel = ResponseModel(false, "1");
    _userModel = UserModel(id: user!.uid, name: user.displayName, email: user.email!, phone: user.phoneNumber);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");

    update();
    return responseModel;

  }
}