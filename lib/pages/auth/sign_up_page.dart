import 'package:e_commercee_app/base/custom_loader.dart';
import 'package:e_commercee_app/base/show_custom_snackbar.dart';
import 'package:e_commercee_app/controllers/auth_controller.dart';
import 'package:e_commercee_app/models/signup_body_model.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/app_text_field.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages=[
      "4.svg", "f.svg", "g.svg"
    ];
    void _registration(AuthController authController){

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if(name.isEmpty){
        showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Password can not be less than six character", title: "Password");
      }else if(password.length < 6){
        showCustomSnackBar("Password can not be less than six character", title: "Password");
      }else{
        showCustomSnackBar("Well done", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            Get.offNamed(RouteHelper.getInitial());
          }
          else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading? SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimenstions.screenHeight*0.05),
            Container(
              height: Dimenstions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                      "assets/images/logo.jpeg"
                  ),
                ),
              ),
            ),
            AppTextField(textEditingController: emailController, hintText: "Email", icon: Icons.email),
            SizedBox(height: Dimenstions.height20),
            AppTextField(isObscure: true, textEditingController: passwordController, hintText: "Password", icon: Icons.password_sharp),
            SizedBox(height: Dimenstions.height20),
            AppTextField(textEditingController: nameController, hintText: "Name", icon: Icons.person),
            SizedBox(height: Dimenstions.height20),
            AppTextField(textEditingController: phoneController, hintText: "Phone", icon: Icons.phone),
            SizedBox(height: Dimenstions.height20),

            GestureDetector(
              onTap: (){
                _registration(_authController);
              },
              child: Container(
                width: Dimenstions.screenWidth/2,
                height: Dimenstions.screenHeight/13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.teal[400]
                ),
                child: Center(
                  child: BigText(
                    text: "Sign up",
                    size: Dimenstions.font20 + Dimenstions.font20/2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimenstions.height10,),
            RichText(text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: "Have an acount already?",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimenstions.font20
                )
            )),
            SizedBox(height: Dimenstions.screenHeight * 0.05),
            RichText(text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: "Sign up using one of the following methods",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimenstions.font20
                )
            )),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: Dimenstions.radius30,
                  child: SvgPicture.asset(
                      "assets/images/"+ signUpImages[index]
                  ) ,
                ),
              )),
            )
          ],
        ),
      ): CustomLoader();
    },
    )
  );

  }
}
