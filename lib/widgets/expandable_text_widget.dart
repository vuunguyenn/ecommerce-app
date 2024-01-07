
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:e_commercee_app/untils/style/colors.dart';
import 'package:e_commercee_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimenstions.screenHeight/5.63;

  @override
  void initState() {
    
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
  print(firstHalf);
  print(secondHalf);
    }
    else{
      firstHalf= widget.text;
      secondHalf = '';
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(size: 16, text: firstHalf): Column(
        children: [
          SmallText(height: 1.8, color: AppColors.neutral50, size: 16, text: hiddenText? (firstHalf+ "..."):(firstHalf+ secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText? 'Show more': 'Show less', color: AppColors.neutral50, size: 15,),
                Icon(hiddenText? Icons.arrow_drop_down: Icons.arrow_drop_up, color: AppColors.green20,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
