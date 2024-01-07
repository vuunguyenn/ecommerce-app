import 'package:e_commercee_app/controllers/cart_controller.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/controllers/recommended_product_controller.dart';
import 'package:e_commercee_app/pages/cart/cart_page.dart';
import 'package:e_commercee_app/pages/home/home_page.dart';
import 'package:e_commercee_app/pages/home/main_food_page.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/app_icon.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:e_commercee_app/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                  if(page == "cartpage"){
                     Get.toNamed(RouteHelper.getCartPage());
                    }
                  else {
                     Get.to(() => HomePage());
                  }},
                    child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                      Get.to(() => CartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 0,
                          top: 0,
                            child: AppIcon(icon: Icons.circle, size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: Colors.teal[400]!,),

                        ):
                        Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 6,
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText( text: product.name!, size: 25,),),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)
                  ,topRight: Radius.circular(20)
                  )
                ),
              ),

            ),
            pinned: true,
            backgroundColor: AppColors.yellow30,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),

            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: product.description!),
                  margin: EdgeInsets.only(left: 20, right: 20),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
       return Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Container(
             padding: EdgeInsets.only(left: 10, right: 10,
                 top:10, bottom: 10),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 GestureDetector(
                   onTap: (){
                     controller.setQuantity(false);
                   },
                   child: AppIcon(iconColor: Colors.white,
                       iconSize: 24,
                       backgroundColor: Colors.teal[400]!,
                       icon: Icons.remove),
                 ),
                 BigText(text: "\$ ${product.price} X  ${controller.inCartItem} ", color: AppColors.neutral90,size: 20),
                 GestureDetector(
                   onTap: (){
                     controller.setQuantity(true);
                   },
                   child: AppIcon(iconColor: Colors.white,
                       iconSize: 24,
                       backgroundColor: Colors.teal[400]!,
                       icon: Icons.add),
                 ),
               ],
             ),
           ),
           Container(
             height: 100,
             padding: EdgeInsets.only(top: 25, bottom: 25, left: 10, right: 10),
             decoration: BoxDecoration(
                 color: AppColors.neutral20,
                 borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(20),
                     topRight: Radius.circular(20)
                 )
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                   margin: EdgeInsets.symmetric(horizontal: Dimenstions.width20),
                     padding: EdgeInsets.only(top: Dimenstions.height10, bottom: Dimenstions.height10, left: Dimenstions.width20, right: Dimenstions.width20),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white
                     ),
                     child: Center(
                       child: Icon(

                         Icons.favorite, color: Colors.teal[400],
                       ),
                     )
                 ),
                 GestureDetector(
                   onTap: (){
                     controller.addItem(product);
                   },
                   child: Container(
                     child: BigText(text: '\$ ${product.price!} | Add to cart', color: Colors.white,),
                     margin: EdgeInsets.only(right: Dimenstions.width10),
                     padding: EdgeInsets.symmetric(vertical: Dimenstions.height20, horizontal: Dimenstions.width10, ),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(Dimenstions.radius20),
                         color: Colors.teal[400]
                     ),
                   ),
                 ),

               ],
             ),
           ),

         ],
       );
      }
        )


    );
  }
}
