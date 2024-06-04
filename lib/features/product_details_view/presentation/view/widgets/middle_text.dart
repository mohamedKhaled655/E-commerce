import 'package:flutter/material.dart';

class MiddleText extends StatelessWidget {
  final String text;
   final TextOverflow ?textOverflow;
   final int ?maxline;
   final double ?fontSize;
   final FontWeight fontWeight;
   final Color? color;
  const MiddleText({
    Key? key,required this.text, this.textOverflow, this.maxline, this.fontSize=20, this.fontWeight= FontWeight.w500, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline,
      overflow:textOverflow ,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontSize: fontSize, fontWeight:fontWeight,color: color ),
    );
  }
}