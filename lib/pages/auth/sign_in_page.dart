import 'package:e_commercee_app/base/custom_loader.dart';
import 'package:e_commercee_app/base/show_custom_snackbar.dart';
import 'package:e_commercee_app/controllers/auth_controller.dart';
import 'package:e_commercee_app/pages/auth/sign_up_page.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/app_text_field.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){


      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Password can not be less than six character", title: "Password");
      }else if(password.length < 6){
        showCustomSnackBar("Password can not be less than six character", title: "Password");
      }else{
        showCustomSnackBar("Well done", title: "Perfect");

        authController.login(email, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }
          else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimenstions.screenHeight*0.05),
              Container(
                height: Dimenstions.screenHeight*0.25,
                child: Center(
                  child: SizedBox()
                  )
                ),
              Container(
                margin: EdgeInsets.only(left: Dimenstions.width30),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimenstions.font20*3 + Dimenstions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(
                          fontSize: Dimenstions.font20,
                          color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimenstions.height20),
              AppTextField(textEditingController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimenstions.height20),
              AppTextField(textEditingController: passwordController, hintText: "Password", icon: Icons.password_sharp),
              SizedBox(height: Dimenstions.height20),

              GestureDetector(
                onTap:() => _login(authController),
                child: Container(
                  width: Dimenstions.screenWidth/2,
                  height: Dimenstions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.teal[400]
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimenstions.font20 + Dimenstions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimenstions.height20,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(text: TextSpan(
                      text: "Sign in your account",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimenstions.font20
                      )
                  )),
                  SizedBox(width: Dimenstions.width20)
                ],
              ),
              SizedBox(height: Dimenstions.screenHeight * 0.05),
              RichText(
                text: TextSpan(
                    text: "Don\'t an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimenstions.font20
                    ),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap =
                              () => Get.to(() => SignUpPage(), transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.neutral90,
                              fontSize: Dimenstions.font20
                          ))
                    ]
                ),
              ),
            ],
          ),
        ): CustomLoader();
      })
      ,
    );
  }
}