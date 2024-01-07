
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimenstions.height20*5,
        width: Dimenstions.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimenstions.height20*5/2),
          color: AppColors.green20
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
