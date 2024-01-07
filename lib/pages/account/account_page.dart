import 'package:e_commercee_app/base/custom_app_bar.dart';
import 'package:e_commercee_app/base/custom_loader.dart';
import 'package:e_commercee_app/controllers/auth_controller.dart';
import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/controllers/location_controller.dart';
import 'package:e_commercee_app/controllers/user_controller.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/account_widget.dart';
import 'package:e_commercee_app/widgets/app_icon.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile", backButtonExist: false,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoading? Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimenstions.height20),
          child: Column(
            children: [
              AppIcon(icon: Icons.person,
                  backgroundColor: Colors.teal[400]!, iconColor: Colors.white,
                  iconSize: Dimenstions.height20*3,
                  size: Dimenstions.height15*10),
              SizedBox(height: Dimenstions.height10*2.5,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AccountWidget(appIcon: AppIcon(icon: Icons.person,
                          backgroundColor: Colors.teal[400]!, iconColor: Colors.white,
                          iconSize: Dimenstions.height20,
                          size: Dimenstions.height10*5),
                          bigText: BigText(text: userController.userModel?.name??"")),
                      SizedBox(height: Dimenstions.height20),
                      AccountWidget(appIcon: AppIcon(icon: Icons.phone,
                          backgroundColor: AppColors.yellow30, iconColor: Colors.white,
                          iconSize: Dimenstions.height20,
                          size: Dimenstions.height10*5),
                          bigText: BigText(text: userController.userModel?.phone??"")),
                      SizedBox(height: Dimenstions.height20,),
                      AccountWidget(appIcon: AppIcon(icon: Icons.email,
                          backgroundColor: AppColors.yellow30, iconColor: Colors.white,
                          iconSize: Dimenstions.height20,
                          size: Dimenstions.height10*5),
                          bigText: BigText(text: userController.userModel?.email??"")),
                      SizedBox(height: Dimenstions.height20,),
                      GetBuilder<LocationController>(builder: (locationController){
                        if(_userLoggedIn&&locationController.addressList.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(appIcon: AppIcon(icon: Icons.location_on,
                                backgroundColor: AppColors.yellow30, iconColor: Colors.white,
                                iconSize: Dimenstions.height20,
                                size: Dimenstions.height10*5),
                                bigText: BigText(text: "Fill in your address")),
                          );
                        }else{
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: AccountWidget(appIcon: AppIcon(icon: Icons.location_on,
                                backgroundColor: AppColors.yellow30, iconColor: Colors.white,
                                iconSize: Dimenstions.height20,
                                size: Dimenstions.height10*5),
                                bigText: BigText(text: "Your address")),
                          );
                        }
                      }),
                      SizedBox(height: Dimenstions.height20,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn())
                          {
                            Get.find<AuthController>().signOut();
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                          else{

                          }
                        },
                        child: AccountWidget(appIcon: AppIcon(icon: Icons.logout,
                            backgroundColor: AppColors.red50, iconColor: Colors.white,
                            iconSize: Dimenstions.height20,
                            size: Dimenstions.height10*5),
                            bigText: BigText(text: "Logout")),
                      ),
                      SizedBox(height: Dimenstions.height20,),

                    ],
                  ),
                ),
              )
            ],
          ),
        )
            :CustomLoader())
            : Container(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimenstions.height20*9,
                  margin: EdgeInsets.only(left: Dimenstions.width20, right:  Dimenstions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimenstions.radius20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/signintocontinue.jpg"
                      )
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimenstions.height20*3,
                    margin: EdgeInsets.only(left: Dimenstions.width20*2, right:  Dimenstions.width20*2, top: Dimenstions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimenstions.radius20),
                      color: AppColors.green60
                    ),
                    child: Center(
                      child: BigText(
                        text: "Sign in", color: AppColors.neutral10,
                      ),
                    ),
                  ),
                ),
              ],
            )));
      })

    );
  }
}