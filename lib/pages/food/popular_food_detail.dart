
import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/pages/cart/cart_page.dart';
import 'package:e_commercee_app/pages/home/home_page.dart';
import 'package:e_commercee_app/pages/home/main_food_page.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/app_column.dart';
import 'package:e_commercee_app/widgets/app_icon.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:e_commercee_app/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(Get.find<CartController>(), product);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimenstions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
              )
          ),

          Positioned(
              top:45,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        if(page == "cartpage"){
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                        else {
                          Get.to(() => HomePage());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back)),

                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                         controller.totalItems>=1?
                         Positioned(
                           right: 0,
                           top: 0,
                             child: AppIcon(icon: Icons.circle, size: 20,
                               iconColor: Colors.transparent,
                               backgroundColor: Colors.teal[400]!),

                         ):
                         Container(),
                          Get.find<PopularProductController>().totalItems>=1?
                          Positioned(
                            right: 5,
                            top: 2,
                            child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12, color: Colors.white,
                            ),
                          ):
                          Container(),
                        ],
                      ),
                    );
                  }),
                ],
              ) ),

          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimenstions.popularFoodImgSize - 20,
              child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Colors.white
            ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimenstions.height15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn( text: product.name!),
                      SizedBox(height: 20,),
                      BigText(text: "Introduce", size: 20),
                      SizedBox(height: 20,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableTextWidget(text: product.description!),
                        ),
                      )
                    ],
                  )
                ),
          ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: 100,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
              color: AppColors.neutral20,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.neutral50,)),
                    SizedBox(width: 8),



                       BigText(text: popularProduct.inCartItem.toString(), color: AppColors.neutral50, size: 22,),

                    SizedBox(width: 8,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.neutral50,))
                  ],
                ),

              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimenstions.height20, horizontal: Dimenstions.width10, ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimenstions.radius20),
                      color: Colors.teal[400],

                  ),
                      child: BigText(text: "\$ ${product.price!}" "  Add to Cart", color: Colors.white,)),
              ),

            ],
          ),
        );
      })

    );
  }
}
