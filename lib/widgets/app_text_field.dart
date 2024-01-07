

import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  AppTextField({super.key, required this.textEditingController,
    required this.hintText, required this.icon,this.maxLines = false, this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimenstions.height20, right: Dimenstions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimenstions.radius30),
          boxShadow: [
            BoxShadow(blurRadius: 10, spreadRadius: 7,
                offset:  Offset(1,10),
                color: Colors.grey.withOpacity(0.2))
          ]
      ),
      child: TextField(
        maxLines: maxLines? 3:1,
        obscureText: isObscure,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenstions.radius30),
              borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenstions.radius30),
              borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white
              )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimenstions.radius30),
          ),
        ),
      ),
    );
  }
}
