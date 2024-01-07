import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/widgets/app_icon.dart';
import 'package:e_commercee_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimenstions.width20, top: Dimenstions.width10
      , bottom: Dimenstions.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimenstions.width20),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 1,
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
    );
  }
}
