import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commercee_app/controllers/popular_product_controller.dart';
import 'package:e_commercee_app/controllers/recommended_product_controller.dart';
import 'package:e_commercee_app/data/repository/custom_repo.dart';
import 'package:e_commercee_app/models/products_model.dart';
import 'package:e_commercee_app/pages/food/popular_food_detail.dart';
import 'package:e_commercee_app/routes/route_helper.dart';
import 'package:e_commercee_app/untils/app_constants.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/app_column.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:e_commercee_app/widgets/icon_and_text_widget.dart';
import 'package:e_commercee_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double height = Dimenstions.pageViewContainer;
  @override
  void initState() {

    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });

  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded ? Container(
            height: Dimenstions.pageView,

              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),

          ):CircularProgressIndicator(
            color: AppColors.green20,
          );
        }),

       GetBuilder<PopularProductController>(builder: (popularProducts){
         return new DotsIndicator(
         dotsCount: popularProducts.popularProductList.isEmpty ? 1: popularProducts.popularProductList.length,
         position: _currPageValue,
    decorator: DotsDecorator(
    activeColor: AppColors.blue60,
    size: const Size.square(9.0),
    activeSize: const Size(19.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
    ),);

       }),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: 10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26),
              ),
              SizedBox(width: 10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing",),
              )
            ],
          ),
        ),
          GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
            return recommendedProduct.isLoaded?
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      // Get.find<CustomRepo>().addDataToFirebase();
                      // print("running");
                      Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: Dimenstions.listViewImgSize,
                            height: Dimenstions.listViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white30,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL+ AppConstants.UPLOAD_URL + recommendedProduct.recommendedProductList[index].img!
                                  )),
                            ),
                          ),
                          Expanded(
                              child:
                              Container(
                                height: Dimenstions.listViewTextContSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)
                                    ),
                                    color: Colors.white
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right:10 ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(size: 20, text: recommendedProduct.recommendedProductList[index].name!),
                                      SizedBox(height: 10,),
                                      SmallText(text: "With chinese chareacteristics"),
                                      SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          BigText(text: "Popular"),
                                          SizedBox(width: 10,),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 3),
                                            child: BigText(text: ".",color: Colors.black26),
                                          ),
                                          SizedBox(width: 10,),
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 2),
                                            child: SmallText(text: "Food pairing",),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                }): CircularProgressIndicator();
          })


      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){
      var currScale = 1- (_currPageValue - index) * (1- _scaleFactor);
      var currTrans = height* (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);


    }else if (index == _currPageValue.floor()+ 1){
      var currScale = _scaleFactor+(_currPageValue-index + 1)*(1-_scaleFactor);
      var currTrans = height* (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);

    }else if (index == _currPageValue.floor()- 1) {
      var currScale = 1- (_currPageValue - index) * (1- _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height*(1-_scaleFactor)/2, 1);
    }


    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
           onTap: (){
             print('run');
             // Get.find<CustomRepo>().process();

             Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
          },
            child: Container(
              height: Dimenstions.pageViewContainer,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenstions.radius30),
                  color: index.isEven?Color(0xFF69c5df): Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                         AppConstants.BASE_URL+ '/uploads/' + popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimenstions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimenstions.width30,
                  right: Dimenstions.width30, bottom: Dimenstions.width30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenstions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0,5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0),
                    ),
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimenstions.height15, left: 15, right: 15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
