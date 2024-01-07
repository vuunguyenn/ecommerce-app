
import 'package:e_commercee_app/data/api/api_client.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserRepo{
  final FirebaseAuth firebaseAuth;
  UserRepo({required this.firebaseAuth});

  Future<User?> getUserInfo() async {
    return await firebaseAuth.currentUser;
  }

}