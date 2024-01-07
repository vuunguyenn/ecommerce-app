import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:e_commercee_app/widgets/icon_and_text_widget.dart';
import 'package:e_commercee_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: 26,),
        SizedBox(height: Dimenstions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: AppColors.green60, size: 15 );}),
            ),
            SizedBox(width: 10),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "1287"),
            const SizedBox(width: 10),
            SmallText(text: "comments")

          ],
        ),
        SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.yellow30),
            SizedBox(width: 1,),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.green60),
            SizedBox(width: 1,),
            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.red50)
          ],
        )
      ],
    );
  }
}
