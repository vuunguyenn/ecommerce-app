
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final Color color;
  const CommonTextButton({super.key, required this.text, this.color = AppColors.neutral10});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimenstions.height20, bottom: Dimenstions.height20, left: Dimenstions.width20, right: Dimenstions.width20 ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0,5),
              blurRadius: 10,
              color: AppColors.green70.withOpacity(0.3)
            )
          ],
            borderRadius: BorderRadius.circular(Dimenstions.radius20),
            color: color
        ),
        child: Center(child: BigText(text: text,)));
  }
}
