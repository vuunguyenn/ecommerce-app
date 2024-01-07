import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({super.key,
    this.color = const Color(0xFF070707), required this.text,
    this.size = 0, this.overflow= TextOverflow.ellipsis
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: TextAlign.start,

      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size == 0? Dimenstions.font20: size,
      ),
    );
  }
}
